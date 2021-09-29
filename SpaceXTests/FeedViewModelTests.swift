//
//  FeedViewModelTests.swift
//  SpaceXTests
//
//  Created by Frederick Dupray on 28/09/2021.
//

import XCTest
@testable import SpaceX

class FeedViewModelTests: XCTestCase {
    
    var router: MockRouter!
    var dataFetcher: MockDataFetcher!
    var viewModel: FeedViewModel!

    override func setUpWithError() throws {
        dataFetcher = MockDataFetcher()
        router = MockRouter()
        viewModel = FeedViewModel(dataFetching: dataFetcher, router: router)
    }

    override func tearDownWithError() throws {
        dataFetcher = nil
        router = nil
        viewModel = nil
    }

    func testFetchDataMethodFetchesLaunchesAndCompanyInfo() throws {
        viewModel.fetchData()
        
        XCTAssert(dataFetcher.didFetchLaunches)
        XCTAssert(dataFetcher.didFetchCompanyInfo)
    }
}
