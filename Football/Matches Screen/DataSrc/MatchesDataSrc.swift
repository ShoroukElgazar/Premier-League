//
//  MatchesDataSrc.swift
//  Football
//
//  Created by Shorouk Mohamed on 11/10/22.
//

import Foundation
import Combine

protocol MatchesDataSrcProtocol{
    func getAllMatches() async throws -> Match?
}

struct MatchesDataSrc: MatchesDataSrcProtocol{
    
    public let apiService: Networkable
    
    init(apiService: Networkable = APIService()) {
        self.apiService = apiService
    }
    
    public func getAllMatches() async throws -> Match? {
        do {
            let matches: Match? = try await apiService.request(target: .matches)
            return matches
        } catch (let error) {
            throw(error)
        }
    }
}


