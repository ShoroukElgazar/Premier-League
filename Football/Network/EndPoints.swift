//
//  EndPoints.swift
//  Moya Tutorial
//
//  Created by Shorouk Mohamed on 11/9/22.
//

import Foundation
import Moya

public enum API: Decodable{
    case matches
}

public enum Paths: String{
    case matchesPath = "/matches"
}


extension API: TargetType{
    // 1
    public var baseURL: URL {
        return URL(string: Strings.baseURL)!
    }

    // 2
    public var path: String {
      switch self {
      case .matches: return Paths.matchesPath.rawValue
      }
    }

    // 3
    public var method: Moya.Method {
      switch self {
      case .matches: return .get
      }
    }

    // 4
    public var sampleData: Data {
      return Data()
    }

    // 5
    public var task: Task {
        return .requestPlain 
    }

    // 6
    public var headers: [String: String]? {
        return ["Content-Type": Strings.Headers.conntentType,
                "X-Auth-Token" : Strings.Headers.authToken]
    }


  
}
