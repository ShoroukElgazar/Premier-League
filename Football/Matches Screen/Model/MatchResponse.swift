//
//  MatchResponse.swift
//  Football
//
//  Created by Shorouk Mohamed on 11/11/22.
//

import ModelMapper

public struct MatchResponse: Codable, Identifiable {
    public let id: Int?
    public let score: Score?
    public var winner: String?
    public let homeTeam: Team?
    public let awayTeam: Team?
    public let competition: Competition?
    public let utcDate: String?
    public let status: Status?
    public let fullDate: String?
    public let matchTime: String?
    public var isFavorite: Bool?
    
    init(id:Int?, score:Score?,winner: String?, homeTeam: Team?,awayTeam: Team?,competition: Competition?,utcDate: String?,status: Status?,fullDate: String?,matchTime: String?,isSelected: Bool? = false) {
        self.id = id
        self.score = score
        self.awayTeam = awayTeam
        self.homeTeam = homeTeam
        self.winner = winner
        self.competition = competition
        self.utcDate = utcDate
        self.status = status
        self.fullDate = fullDate
        self.matchTime = matchTime
        self.isFavorite = isSelected
    }
}

public class MatchResponseMapper: Mapper {
    var winner = ""
    var soccerDate = ""
    public func map(_ input: MatchElement) -> MatchResponse{

        guard let status = input.status else{
            return MatchResponse(id: 0, score: nil, winner: "", homeTeam: nil, awayTeam: nil, competition: nil, utcDate: nil, status: nil, fullDate: nil, matchTime: nil)
        }
        switch status{
        case .finished:
            winner = getWinnner(input: input)
        case .postponed:
            winner = Strings.notApplicable
        case .scheduled:
            winner = Strings.notApplicable
        case .timed:
            winner = Strings.notApplicable
        case .inPlay:
            winner = Strings.notApplicable
        }
        
        return MatchResponse(id: input.id, score: input.score, winner: winner, homeTeam: input.homeTeam, awayTeam: input.awayTeam, competition: input.competition, utcDate:  input.utcDate!, status: status, fullDate: getFullDate(date: input.utcDate!), matchTime: getMatchDate(date: input.utcDate!) )
    }
    public func getFullDate(date: String) -> String?{
        return DateHelper().formatToStr(str: date, format: .dateFormat, toFormat: .fullDate)
    }
    public func getMatchDate(date: String) -> String?{
        return DateHelper().formatToStr(str: date, format: .dateFormat, toFormat: .timeFormat)
    }
   
    private func getWinnner(input: MatchElement) -> String{
        guard let winner = input.score?.winner else{
            return Strings.notApplicable
        }
        switch winner{
        case .awayTeam:
            return input.awayTeam?.name ?? Strings.notApplicable
        case .draw:
            return Strings.draw
        case .homeTeam:
            return input.homeTeam?.name ?? Strings.notApplicable
        }
    }
}
