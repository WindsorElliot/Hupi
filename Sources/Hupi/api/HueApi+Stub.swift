//
//  File.swift
//  
//
//  Created by Elliot Cunningham on 27/05/2021.
//

import Foundation

extension HueApi {
    var stubedData: String {
        switch self {
        case .searchBridge:
            return "[{\"id\":\"001788fffe100491\",\"internalipaddress\":\"192.168.2.23\",\"macaddress\":\"00:17:88:10:04:9\",\"name\":\"Philips Hue\"}]"
        case .connect(_, _):
            return "[{\"success\":{\"username\":\"1234bridgeapp\"}}]"
        }
    }
}
