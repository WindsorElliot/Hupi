//
//  File.swift
//  
//
//  Created by Elliot Cunningham on 27/05/2021.
//

import Foundation

struct HueBridgeConnectBodyResponse: Codable {
    let error: HueBridgeFaillure?
    let success: HueBridgeSuccess?
}

struct HueBridgeFaillure: Codable {
    let type: String
    let address: String
    let description: String
}

struct HueBridgeSuccess: Codable {
    let username: String
}
