//
//  SpaceXDataManager.swift
//  SpaceX
//
//  Created by Frederick Dupray on 27/09/2021.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

class SpaceXDataManager {
    
    let urlSession: URLSessionProtocol
    
    fileprivate var limit: Int = 5
    fileprivate var offset: Int = 0
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
}

extension SpaceXDataManager: DataFetching {
    
    func fetchLaunches(success: @escaping LaunchResultHandler, failure: @escaping ErrorHandler) {
                        
        var urlComp = URLComponents(string: "https://api.spacexdata.com/v5/launches")
        
        guard let url = urlComp?.url else { return }
                
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
                
        let task = urlSession.dataTask(with: request) { data, response, error in
            
            if let _data = data,
               let json = try? JSONDecoder().decode([Launch].self, from: _data) {
                success(json)
            }
            
            if let error = error {
                failure(error)
            }
        }
        
        task.resume()
    }
    
    func fetchRockets(success: @escaping RocketResultHandler, failure: @escaping ErrorHandler) {
        
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = urlSession.dataTask(with: request) { data, response, error in
            
            if let _data = data,
               let json = try? JSONDecoder().decode([Rocket].self, from: _data) {
                success(json)
            }
            
            if let error = error {
                failure(error)
            }
        }
        
        task.resume()
    }
    
    func fetchCompanyInfo(success: @escaping CompanyInfoResultHandler, failure: @escaping ErrorHandler) {
     
        guard let url = URL(string: "https://api.spacexdata.com/v4/company") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = urlSession.dataTask(with: request) { data, response, error in
            
            if let _data = data,
               let json = try? JSONDecoder().decode(CompanyInfo.self, from: _data) {
                success(json)
            }
            
            if let error = error {
                failure(error)
            }
        }
        
        task.resume()
    }
}

class MockURLSession: URLSessionProtocol {
    
    var url: URL?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.url = request.url
        return URLSession.shared.dataTask(with: request)
    }
}
