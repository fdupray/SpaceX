//
//  SpaceXTests.swift
//  SpaceXTests
//
//  Created by Frederick Dupray on 27/09/2021.
//

import XCTest
@testable import SpaceX

class RouterTests: XCTestCase {
    
    var router = MockRouter()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        router.reset()
    }
    
    func testPopoverIsPresented() throws {
        router.popover(show: true)
        XCTAssertTrue(router.didShowPopover)
    }
    
    func testPopoverIsHidden() throws {
        router.popover(show: false)
        XCTAssertTrue(router.didHidePopover)
    }
}
