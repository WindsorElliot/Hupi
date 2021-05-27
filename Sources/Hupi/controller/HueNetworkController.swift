//
//  File.swift
//  
//
//  Created by Elliot Cunningham on 27/05/2021.
//

import Foundation
import Moya

class HueNetworkController {
    private static var provider: MoyaProvider<HueApi> {
        let isTesting: Bool = NSClassFromString("XCTestCase") != nil
        return isTesting
            ? MoyaProvider<HueApi>(stubClosure: { (_) -> StubBehavior in return .immediate  })
            : MoyaProvider<HueApi>(
                endpointClosure: HueNetworkController._endPointClosure,
                requestClosure: HueNetworkController._requestClosure
            )
    }
    
    private static let _requestClosure = { (endpoint: Moya.Endpoint, done: MoyaProvider.RequestResultClosure) in
        do {
            var request = try endpoint.urlRequest()
            done(.success(request))
        } catch {
            done(.failure(MoyaError.underlying(error, nil)))
        }
    }
    
    private static let _endPointClosure = { (target: HueApi) -> Endpoint in
        let url = target.baseURL.appendingPathComponent(target.path).absoluteString
        let endPoint: Endpoint = Endpoint(url: url, sampleResponseClosure: {() -> EndpointSampleResponse in
            .networkResponse(200, target.sampleData)
        }, method: target.method, task: target.task, httpHeaderFields: target.headers)
        
        return endPoint
    }
    
    private static func isRequestSucceed(_ response: Response) -> Bool {
        if response.statusCode >= 200 && response.statusCode <= 299 {
            return true
        }
        return false
    }
    
    private static func mapResponseToError(response: Response) -> Error {
        if response.data.count == 0 {
            return NSError(domain: "Moya", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: "Unknow error on call \n \(response.debugDescription)"])
        }
        
        guard let message = String(data: response.data, encoding: .utf8) else {
            return NSError(domain: "Moya", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: "Unknow error on call \n \(response.debugDescription)"])
        }
        
        return NSError(domain: "Moya", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: "Erreur \n \(message)"])
    }
    
    static func requestApi<C: Codable>(
        _ target: HueApi,
        successCompletion: @escaping(_ response: C) -> Void,
        faillureCompletion: @escaping(_ error: Error) -> Void
    ){
        provider.request(target) { result in
            switch result {
            case .success(let response):
                if true == HueNetworkController.isRequestSucceed(response) {
                    do {
                        let body = try JSONDecoder().decode(C.self, from: response.data)
                        successCompletion(body)
                    }
                    catch {
                        faillureCompletion(error)
                    }
                } else {
                    faillureCompletion(HueNetworkController.mapResponseToError(response: response))
                }
            case .failure(let error):
                faillureCompletion(error)
            }
        }
    }
}
