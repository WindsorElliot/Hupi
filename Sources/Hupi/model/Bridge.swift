//
//  File.swift
//  
//
//  Created by Elliot Cunningham on 27/05/2021.
//

import Foundation


public class Bridge: NSObject {
    
    public let id: String
    public let internalIpAddress: String
    public let macAddress: String
    public let name: String
    
    
    init(_ bridge: HueBridge) {
        self.id = bridge.id
        self.internalIpAddress = bridge.internalipaddress
        self.macAddress = bridge.macaddress
        self.name = bridge.name
        
        super.init()
    }
}
