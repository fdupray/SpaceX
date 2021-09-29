//
//  PopoverView.swift
//  SpaceX
//
//  Created by Frederick Dupray on 28/09/2021.
//

import SwiftUI
import Combine

enum Filter {
    case ascending
    case descending
}

struct PopoverViewModel {
    
    private var router: Routing
    
    var action = PassthroughSubject<Filter, Never>()
    
    init(router: Routing) {
        self.router = router
    }
    
    func selectedFilter(filter: Filter) {
        action.send(filter)
        router.popover(show: false)
    }
}

struct PopoverView: View {
    
    var viewModel: PopoverViewModel
    
    var body: some View {
        
        VStack (spacing: 16) {
                        
            OptionButton(title: "Ascending") {
                viewModel.selectedFilter(filter: .descending)
            }
                        
            OptionButton(title: "Descending") {
                viewModel.selectedFilter(filter: .descending)
            }
        }
    }
}

private struct OptionButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        
        Button(title, action: action)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .center)
    }
}

struct PopoverView_Previews: PreviewProvider {
    static var previews: some View {
        PopoverView(viewModel: PopoverViewModel(router: MockRouter()))
    }
}
