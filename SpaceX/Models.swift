//
//  LaunchModel.swift
//  SpaceX
//
//  Created by Frederick Dupray on 27/09/2021.
//

import Foundation
import SwiftUI

struct CompanyInfo: Decodable {
    
    let name: String
    let founder: String
    let founded: Int
    let employees: Int
    let launch_sites: Int
    let valuation: Double
    
    var description: String {
        return "\(name) was founded by \(founder) in \(founded). It has now \(employees) employees, \(launch_sites) launch sites, and is valued at USD\(valuation)."
    }
}

struct Launch: Decodable {
    let id: String
    let name: String
    let rocket: String
    let date_local: String
    let success: Bool?
    let links: Links?
    
    var formattedDateString: String {
        ""
    }

    var formattedDaysString: String {
        ""
    }
    
    var rocketObject: Rocket?
}

struct Rocket: Decodable {
    let id: String
    let name: String
    let type: String
}

struct Links: Decodable {
    let patch: Patch?
    let youtube_id: String?
    let wikipedia: String?
    let article: String?
}

struct Patch: Decodable {
    let small: String?
}
