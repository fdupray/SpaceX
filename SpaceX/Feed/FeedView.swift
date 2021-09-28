//
//  ContentView.swift
//  SpaceX
//
//  Created by Frederick Dupray on 27/09/2021.
//

import SwiftUI

struct FeedView: View {
    
    @ObservedObject var viewModel: FeedViewModel
    
    @State var isFilterPopoverPresented: Bool = false
    
    var body: some View {
        
        if viewModel.launches.isEmpty {
            
            NoLaunchesView()
        }
        
        else {
            
            LaunchesTable(companyInfo: $viewModel.companyInfo, launches: $viewModel.launches)
                .toolbar {
                    Button {
                        
                        viewModel.router.popover(show: true)
                        
                    } label: {
                         
                        Text("Filter")
                            .foregroundColor(.blue)
                    }
                    .fullScreenCover(isPresented: $viewModel.isPopoverPresented) {
                        
                        if viewModel.isPopoverPresented {
                            
                            viewModel.router.popover(show: false)
                        }
                        
                    } content: {
                        
                        viewModel.router.popoverView()
                    }
                }
        }
    }
}

/* -- PLEASE READ !!!!
 
These views could be (and in many cases, should be) separated in different files. However, for this case I'm regrouping them in one file!
 
*/

struct LaunchesTable: View {
    
    @Binding var companyInfo: CompanyInfo?
    @Binding var launches: [Launch]
    
    var body: some View {
        
        ScrollView(.vertical) {
            
            Section (header: SectionHeader(title: "Company")) {
                
                Text(companyInfo?.description ?? "Welcome to SpaceX 🚀")
                    .spaceXFont(.body)
                    .padding()
            }
            
            Section (header: SectionHeader(title: "Launches")) {
                
                ForEach (0..<launches.count) { i in
                    
                    FeedCellView(viewModel: FeedCellViewModel(launch: launches[i]))
                        .padding()
                }
            }
        }
    }
}

struct NoLaunchesView: View {
    
    var body: some View {
        
        VStack {
            
            Image("error_icon")
                .padding()
            
            Text("We couldn't load content")
                .spaceXFont(.body)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(viewModel: FeedViewModel(dataFetching: MockDataFetcher(), router: MockRouter()))
    }
}
