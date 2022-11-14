//
//  ResponseError.swift
//  Football
//
//  Created by Shorouk Mohamed on 11/14/22.
//

import Foundation

enum ResponseError: LocalizedError {
    case decoding
    case network(message: String)
    case unauthenticated
    case offline
    case serverError(message:String)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .decoding:
            return Strings.Error.general
        case .network(let message):
            return message
        case .unauthenticated:
            return Strings.Error.authentication
        case .offline:
            return Strings.Error.connection
        case .unknown:
            return Strings.Error.general
        case .serverError(let message):
            return message
        }
    }
}
