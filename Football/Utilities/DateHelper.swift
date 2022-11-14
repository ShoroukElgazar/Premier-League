//
//  DateHelper.swift
//  Football
//
//  Created by Shorouk Mohamed on 11/12/22.
//

import Foundation

public class DateHelper{
    
    public enum Format: String {
        case timeFormat = "HH:mm"
        case dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        case fullDate = "dd-MM-yyyy"
    }
    
    public func formatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = tempLocale
        return dateFormatter
    }
    
    public func formatToStr(str:String,format: Format, toFormat: Format) -> String {
        let dateFormatter = formatter()
        dateFormatter.dateFormat = format.rawValue
        let date = dateFormatter.date(from: str)!
        dateFormatter.dateFormat = toFormat.rawValue
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    public func getCurrentDate() -> Date?{
        let dateFormatter = formatter()
        dateFormatter.dateFormat = Format.dateFormat.rawValue
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        let toDate = dateFormatter.date(from: dateString)!
        dateFormatter.dateFormat = Format.fullDate.rawValue
        return toDate
    }
    
    public func getMatchDate(val:String) -> Date?{
        let dateFormatter = formatter()
        dateFormatter.dateFormat = Format.dateFormat.rawValue
        let date = dateFormatter.date(from: val)!
        return date
    }
    
}

