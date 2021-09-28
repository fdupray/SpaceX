//
//  Router.swift
//  SpaceX
//
//  Created by Frederick Dupray on 28/09/2021.
//

import Foundation
import Combine
import SwiftUI

protocol Routing {
    
    var isPopoverPresented: CurrentValueSubject<Bool, Never> { get }
    var filter: PassthroughSubject<Filter, Never> { get }
    
    func popover(show: Bool)
    
    func popoverView() -> AnyView
}

class Router {
    
    @Published var isPopoverPresented = CurrentValueSubject<Bool, Never>(false)
    @Published var filter = PassthroughSubject<Filter, Never>()
}

extension Router: Routing {
    
    func popoverView() -> AnyView {
        
        let viewModel = PopoverViewModel(router: self)
        return AnyView(PopoverView(viewModel: viewModel))
    }
    
    func popover(show: Bool) {
        
        if show {
            
            DispatchQueue.main.async {
                self.isPopoverPresented.send(true)
            }
        }
        
        else {
         
            DispatchQueue.main.async {
                self.isPopoverPresented.send(false)
            }
        }
    }
}

//MOCK
class MockRouter: Routing {
    
    var isPopoverPresented: CurrentValueSubject<Bool, Never> = .init(false)
    var filter: PassthroughSubject<Filter, Never> = .init()
    
    var didHidePopover = false
    var didShowPopover = false
    
    func reset() {
        didHidePopover = false
        didShowPopover = false
    }
    
    func popover(show: Bool) {
        
        if show == true {
            
            isPopoverPresented.send(true)
            didShowPopover = true
        }
        
        else {
         
            isPopoverPresented.send(false)
            didHidePopover = true
        }
    }
    
    func popoverView() -> AnyView {
        return AnyView(PopoverView(viewModel: PopoverViewModel(router: MockRouter())))
    }
}
