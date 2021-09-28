//
//  SpaceXApp.swift
//  SpaceX
//
//  Created by Frederick Dupray on 27/09/2021.
//

import SwiftUI

@main
struct SpaceXApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                //A DI container could be user for these services
                FeedView(viewModel: FeedViewModel(dataFetching: SpaceXDataManager(), router: Router()))
                    .navigationBarTitleDisplayMode(.large)
                    .navigationTitle("SpaceX")
            }
        }
    }
}
