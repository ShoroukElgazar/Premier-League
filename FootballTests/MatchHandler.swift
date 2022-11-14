//
//  MatchHandler.swift
//  FootballTests
//
//  Created by Shorouk Mohamed on 11/13/22.
//

import XCTest
@testable import Football

struct MatchHandler {
    struct Spies {
        static let apiService = ApiServiceSpy()
        static let matchesDataSrcProtocolSpy = MatchesDataSrcProtocolSpy()
        static let matchesRepoProtocolSpy = MatchesRepoProtocolSpy()

    }
    static var DummyObjects = MatchDummyObjects()
}

class ApiServiceSpy: Networkable {
    var isRequestCalled = false

    func request<T>(target: Football.API) async throws -> T where T : Decodable {
        isRequestCalled  = true
        return MatchHandler.DummyObjects.MatchItem as! T
    }
}
class MatchesDataSrcProtocolSpy: MatchesDataSrcProtocol{
    var isGetAllMatchesCalled = false

    func getAllMatches() async -> Football.Match? {
        isGetAllMatchesCalled = true
        return MatchHandler.DummyObjects.MatchItem
    }

}
class MatchesRepoProtocolSpy: MatchesRepoProtocol{
    var isGetMatchesCalled = false
    
    func getMatches() async throws -> [Football.MatchResponse] {
        isGetMatchesCalled = true
        return [MatchHandler.DummyObjects.Match]
    }
}
struct MatchDummyObjects{

    let fullTime = Time(home: 2, away: 0)
    let halfTime = Time(home: 0, away: 0)
    
    lazy var score = Score(winner: .homeTeam,
                      duration: "REGULAR",
                      fullTime: fullTime,
                      halfTime: halfTime)

    let homeTeam = Team(id: 67.0,
                         name: "Newcastle United FC",
                         shortName: "Newcastle",
                         tla: "NEW",
                         crest: "https://crests.football-data.org/67.png")

    let awayTeam = Team(id: 351.0,
                         name: "Nottingham Forest FC",
                         shortName: "Nottingham",
                         tla: "NOT",
                         crest: "https://crests.football-data.org/351.png")
    let status : Status = .finished

    let competition = Competition(id: 2021,
                              name: "Premier League",
                              code: "PL",
                              type: "LEAGUE",
                              emblem: "https://crests.football-data.org/PL.png")
    lazy var Match =  MatchResponse(id: 416379,
                               score: score,
                               winner: "Newcastle United FC",
                               homeTeam: homeTeam,
                               awayTeam: awayTeam,
                               competition: competition,
                               utcDate: "2022-08-06T14:00:00Z",
                               status: status,
                               fullDate: "06-08-2022",
                               matchTime: "16:00")
    lazy var MatchItem = Football.Match(competition: nil, matches: nil)
}
