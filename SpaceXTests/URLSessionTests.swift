//
//  SpaceXDataManagerTests.swift
//  SpaceXTests
//
//  Created by Frederick Dupray on 28/09/2021.
//

import XCTest
@testable import SpaceX

class URLSessionTests: XCTestCase {
    
    var dataManager: SpaceXDataManager!
    var urlSessionMock: MockURLSession!

    override func setUpWithError() throws {
        urlSessionMock = MockURLSession()
        dataManager = SpaceXDataManager(urlSession: urlSessionMock)
    }

    override func tearDownWithError() throws {
        urlSessionMock = nil
        dataManager = nil
    }

    func testGETRequests() throws {
        
        let url = URL(string: "https://api.spacexdata.com/v5/launches")!
        
        let _ = dataManager.urlSession.dataTask(with: URLRequest(url: url)) { data, response, error in

        }
                
        XCTAssertEqual(urlSessionMock.url, url)
    }
}
