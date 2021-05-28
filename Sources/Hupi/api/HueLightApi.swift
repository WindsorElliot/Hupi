//
//  HueLightApi.swift
//  
//
//  Created by Elliot Cunningham on 28/05/2021.
//

import Foundation
import Moya

enum HueLightApi {
    case getLights(hubIp: String, username: String)
}

extension HueLightApi: TargetType {
    var baseURL: URL {
        switch self {
        case .getLights(let hubIp, let username):
            return URL(string: "http://\(hubIp)/api/\(username)/")!
        }
    }
    
    var path: String {
        switch self {
        case .getLights:
            return "lights"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getLights:
            return .get
        }
    }
    
    var sampleData: Data {
        return "Simple data".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .getLights:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "Application/json"]
    }
    
}
