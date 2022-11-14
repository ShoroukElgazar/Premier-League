//
//  Strings.swift
//  Football
//
//  Created by Shorouk Mohamed on 11/14/22.
//

import Foundation

struct Strings {
    
    public static let baseURL = "https://api.football-data.org/v4/competitions/2021"
    public static let toggleFav = "Fav"
    public static let winner = "Winner is"
    public static let error = "Error"
    public static let notApplicable = "N/A"
    public static let draw = "Draw"
    public static let all = "All"
    public static let following = "Following"
    public static let follow = "Follow"
    public static let ok = "OK"
    
    struct Headers{
        public static let authToken = "1f36f350436f415faef6bdba9e6f8dac"
        public static let conntentType = "application/json"
    }
    struct Error {
        public static let emptyData = "There is no available data"
        public static let connection = "Connection is lost, please try again."
        public static let general = "Something went wrong."
        public static let authentication = "Please log in to continue"
    }
}
