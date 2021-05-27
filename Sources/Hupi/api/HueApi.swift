//
//  File.swift
//  
//
//  Created by Elliot Cunningham on 27/05/2021.
//

import Foundation
import Moya

enum HueApi {
    case searchBridge
    case connect(address: String, appName: String)
}

extension HueApi: TargetType {
    var baseURL: URL {
        switch self {
        case .searchBridge:
            return URL(string: "https://discovery.meethue.com/")!
        case .connect(let address, _):
            return URL(string: "htpp://\(address)/")!
        }
    }
    
    var path: String {
        switch self {
        case .searchBridge:
            return ""
        case .connect:
            return "api"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .searchBridge:
            return .get
        case .connect:
            return .post
        }
    }
    
    var sampleData: Data {
        return self.stubedData.data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .searchBridge:
            return .requestPlain
        case .connect(_, let appName):
            let body = HueBridgeConnectBodyRequest(devicetype: appName)
            return .requestJSONEncodable(body)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "Application/json"]
    }
    
    
}
