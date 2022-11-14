
import Foundation

// MARK: - Match
public struct Match: Codable {
    public let competition: Competition?
    public let matches: [MatchElement]?

    enum CodingKeys: String, CodingKey {
        case competition = "competition"
        case matches = "matches"
    }

    public init(competition: Competition?, matches: [MatchElement]?) {
        self.competition = competition
        self.matches = matches
    }
}

// MARK: - Competition
public struct Competition: Codable {
    public let id: Int?
    public let name: String?
    public let code: String?
    public let type: String?
    public let emblem: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case code = "code"
        case type = "type"
        case emblem = "emblem"
    }

    public init(id: Int?, name: String?, code: String?, type: String?, emblem: String?) {
        self.id = id
        self.name = name
        self.code = code
        self.type = type
        self.emblem = emblem
    }
}

// MARK: - MatchElement
public struct MatchElement: Codable {
    public let area: Area?
    public let competition: Competition?
    public let season: Season?
    public let id: Int?
    public let utcDate: String?
    public let status: Status?
    public let matchday: Int?
    public let stage: String?
    public let homeTeam: Team?
    public let awayTeam: Team?
    public let score: Score?

    enum CodingKeys: String, CodingKey {
        case area = "area"
        case competition = "competition"
        case season = "season"
        case id = "id"
        case utcDate = "utcDate"
        case status = "status"
        case matchday = "matchday"
        case stage = "stage"
        case homeTeam = "homeTeam"
        case awayTeam = "awayTeam"
        case score = "score"
    }

    public init(area: Area?, competition: Competition?, season: Season?, id: Int?, utcDate: String?, status: Status?, matchday: Int?, stage: String?, homeTeam: Team?, awayTeam: Team?, score: Score?) {
        self.area = area
        self.competition = competition
        self.season = season
        self.id = id
        self.utcDate = utcDate
        self.status = status
        self.matchday = matchday
        self.stage = stage
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.score = score
    }
}

// MARK: - Area
public struct Area: Codable {
    public let id: Double?
    public let name: String?
    public let code: String?
    public let flag: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case code = "code"
        case flag = "flag"
    }

    public init(id: Double?, name: String?, code: String?, flag: String?) {
        self.id = id
        self.name = name
        self.code = code
        self.flag = flag
    }
}

//public enum AreaCode: String, Codable {
//    case eng = "ENG"
//}


// MARK: - Team
public struct Team: Codable {
    public let id: Double?
    public let name: String?
    public let shortName: String?
    public let tla: String?
    public let crest: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case shortName = "shortName"
        case tla = "tla"
        case crest = "crest"
    }

    public init(id: Double?, name: String?, shortName: String?, tla: String?, crest: String?) {
        self.id = id
        self.name = name
        self.shortName = shortName
        self.tla = tla
        self.crest = crest
    }
}

// MARK: - Score
public struct Score: Codable {
    public let winner: Winner?
    public let duration: String?
    public let fullTime: Time?
    public let halfTime: Time?

    enum CodingKeys: String, CodingKey {
        case winner = "winner"
        case duration = "duration"
        case fullTime = "fullTime"
        case halfTime = "halfTime"
    }

    public init(winner: Winner?, duration: String?, fullTime: Time?, halfTime: Time?) {
        self.winner = winner
        self.duration = duration
        self.fullTime = fullTime
        self.halfTime = halfTime
    }
}



// MARK: - Time
public struct Time: Codable {
    public let home: Int?
    public let away: Int?

    enum CodingKeys: String, CodingKey {
        case home = "home"
        case away = "away"
    }

    public init(home: Int?, away: Int?) {
        self.home = home
        self.away = away
    }
}

public enum Winner: String, Codable {
    case awayTeam = "AWAY_TEAM"
    case draw = "DRAW"
    case homeTeam = "HOME_TEAM"
}

// MARK: - Season
public struct Season: Codable {
    public let id: Int?
    public let startDate: String?
    public let endDate: String?
    public let currentMatchday: Int?
    public let winner: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case startDate = "startDate"
        case endDate = "endDate"
        case currentMatchday = "currentMatchday"
        case winner = "winner"
    }

    public init(id: Int?, startDate: String?, endDate: String?, currentMatchday: Int?, winner: String?) {
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.currentMatchday = currentMatchday
        self.winner = winner
    }
}



public enum Status: String, Codable {
    public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)
            self = Status(rawValue: string) ?? .timed
        }
    case finished = "FINISHED"
    case postponed = "POSTPONED"
    case scheduled = "SCHEDULED"
    case timed = "TIMED"
    case inPlay = "IN_PLAY"
}

// MARK: - ResultSet
public struct ResultSet: Codable {
    public let count: Int?
    public let first: String?
    public let last: String?
    public let played: Int?

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case first = "first"
        case last = "last"
        case played = "played"
    }

    public init(count: Int?, first: String?, last: String?, played: Int?) {
        self.count = count
        self.first = first
        self.last = last
        self.played = played
    }
}

