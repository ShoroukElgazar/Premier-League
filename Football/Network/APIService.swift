//
//  APIService.swift
//  Moya Tutorial
//
//  Created by Shorouk Mohamed on 11/9/22.
//

import Moya
import Foundation
import Combine
import Alamofire

public protocol Networkable {
    func request<T: Decodable>(target: API) async throws -> T
}
public class APIService {
    var provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
}


extension APIService: Networkable{
    
    public func request<T: Decodable>(target: API) async throws -> T
    {
        return try await withCheckedThrowingContinuation { continuation in
            execute(target: target) { (response: T?, error) in
                if let error = error{
                    continuation.resume(throwing: error)
                }else{
                    let result = response
                    continuation.resume(returning: result!)
                }
            }
        }
    }
    
    func execute<T: Decodable>(target: API,_ completion: @escaping (_ response: T?, _ error: Error?) -> Void) {
        if NetworkReachabilityManager()?.isReachable ?? false {
            provider.request(target){ result in
                switch result {
                case let .success(response):
                    if response.statusCode >=  200 && response.statusCode <= 299{
                        do {
                            let results = try JSONDecoder().decode(T.self, from: response.data)
                            completion(results, nil)
                        } catch let error {
                            completion(nil,ResponseError.decoding)
                        }
                    }else{
                        completion(nil,ResponseError.unknown)
                    }
                case let .failure(error):
                    completion(nil,ResponseError.network(message: error.localizedDescription))
                }
            }
        }else{
            completion(nil,ResponseError.offline)
        }
        
    }
    
}


