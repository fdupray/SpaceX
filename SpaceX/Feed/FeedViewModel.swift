//
//  FeedViewModel.swift
//  SpaceX
//
//  Created by Frederick Dupray on 27/09/2021.
//

import Foundation
import Combine

class FeedViewModel: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    
    //Services
    let router: Routing
    let dataFetching: DataFetching
        
    //Data
    @Published var companyInfo: CompanyInfo?
    @Published var launches: [Launch] = []
    @Published var error: Error?
    @Published var isPopoverPresented: Bool = false
    
    private var filter: Filter = .descending
    
    init(dataFetching: DataFetching, router: Routing) {
        self.dataFetching = dataFetching
        self.router = router
        
        subscribe()
        fetchData()
    }
    
    func fetchData() {
        
        var launches: [Launch] = []
        var companyInfo: CompanyInfo?
        
        let group = DispatchGroup()
        
        group.enter()
        
        dataFetching.fetchLaunches { result in
            launches = result
            group.leave()
        } failure: { [weak self] err in
            DispatchQueue.main.async {
                self?.error = err
            }
        }
        
        group.enter()
        
        dataFetching.fetchCompanyInfo { result in
            companyInfo = result
            group.leave()
        } failure: { [weak self] err in
            DispatchQueue.main.async {
                self?.error = err
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.launches = launches
            self.companyInfo = companyInfo
        }
    }
    
    func filterData(filter: Filter) {
        
        switch filter {
            
        case .ascending:
            
//            launches = launches.sorted(by: {  })
            break
            
        case .descending:
            
//            launches = launches.sorted(by: { true })
            break
        }
    }
        
    func subscribe() {
        
        router.isPopoverPresented
            .removeDuplicates()
            .sink { [weak self] value in
                DispatchQueue.main.async {
                    self?.isPopoverPresented = value
                }
            }
            .store(in: &cancellables)
        
        router.filter
            .removeDuplicates()
            .sink { [weak self] filter in
                DispatchQueue.main.async {
                    self?.filter = filter
                }
            }
            .store(in: &cancellables)
    }
}
