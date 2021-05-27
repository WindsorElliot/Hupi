//
//  HueHubNetworkDiscover.swift
//  
//
//  Created by Elliot Cunningham on 27/05/2021.
//

import Foundation

public class HueHubNetworkDiscover {
    private let appName: String
    
    public init(_ appName: String) {
        self.appName = appName
    }
    
    
    public func retriveHueBridgeInNetwork(completion: @escaping(Result<[Bridge], Error>) -> Void) {
        let target: HueApi = .searchBridge
        HueNetworkController.requestApi(target) { (res: [HueBridge]) in
            let bridges = res.compactMap({ Bridge($0) })
            completion(.success(bridges))
        } faillureCompletion: { error in
            completion(.failure(error))
        }
    }
    
    public func connectHueBridge(_ hueIpAddress: String, completion: @escaping(Result<String, Error>) -> Void) {
        let target: HueApi = .connect(address: hueIpAddress, appName: self.appName)
        HueNetworkController.requestApi(target) { (res: [HueBridgeConnectBodyResponse]) in
            if let success = res.first?.success {
                completion(.success(success.username))
            } else if let faillure = res.first?.error {
                completion(.failure(NSError(domain: "Hue", code: Int(faillure.type) ?? 0, userInfo: [NSLocalizedDescriptionKey: faillure.description])))
            } else {
                completion(.failure(NSError(domain: "Hue", code: 0, userInfo: [NSLocalizedDescriptionKey: "Erreur inconnue"])))
            }
        } faillureCompletion: { error in
            completion(.failure(error))
        }

    }
    
    
}
