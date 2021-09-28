//
//  DataManager.swift
//  SpaceX
//
//  Created by Frederick Dupray on 27/09/2021.
//

import Foundation

typealias LaunchResultHandler = ([Launch]) -> Void
typealias RocketResultHandler = ([Rocket]) -> Void
typealias CompanyInfoResultHandler = (CompanyInfo) -> Void
typealias ErrorHandler = (Error) -> Void

protocol DataFetching {
    func fetchLaunches(success: @escaping LaunchResultHandler, failure: @escaping ErrorHandler)
    func fetchCompanyInfo(success: @escaping CompanyInfoResultHandler, failure: @escaping ErrorHandler)
    func fetchRockets(success: @escaping RocketResultHandler, failure: @escaping ErrorHandler)
}

class MockDataFetcher: DataFetching {
    
    var didFetchLaunches = false
    var didFetchRockets = false
    var didFetchCompanyInfo = false
    
    func fetchLaunches(success: @escaping LaunchResultHandler, failure: @escaping ErrorHandler) {
        didFetchLaunches = true
    }
    
    func fetchRockets(success: @escaping RocketResultHandler, failure: @escaping ErrorHandler) {
        didFetchRockets = true
    }
    
    func fetchCompanyInfo(success: @escaping CompanyInfoResultHandler, failure: @escaping ErrorHandler) {
        didFetchCompanyInfo = true
    }
}
