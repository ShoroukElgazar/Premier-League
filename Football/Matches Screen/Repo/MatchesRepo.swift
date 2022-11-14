//
//  MatchesRepo.swift
//  Football
//
//  Created by Shorouk Mohamed on 11/10/22.
//

import Combine

public let match = MatchesRepo.build()

protocol MatchesRepoProtocol{
    func getMatches() async throws ->  [MatchResponse]
}

public struct MatchesRepo : MatchesRepoProtocol {
    let src: MatchesDataSrcProtocol
    
    func getMatches() async throws ->  [MatchResponse] {
        var local : [MatchResponse] = []
        do{
            let matches = try await src.getAllMatches()
            guard let items = matches?.matches else{
                return []
            }
            for match in items{
                local.append(MatchResponseMapper().map(match))
            }
            return local
        } catch (let error) {
            throw(error)
        }
    }
    
}

public extension MatchesRepo {
    static func build() -> MatchesRepo {
        MatchesRepo(src: MatchesDataSrc())
    }
}
