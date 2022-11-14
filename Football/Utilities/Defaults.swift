//
//  Defaults.swift
//  Football
//
//  Created by Shorouk Mohamed on 11/13/22.
//

import Foundation

public var defaults = Defaults()

enum DefaultsKey {
    case FAV_MATCH
   
    var name: String {
        get {
            "\(self)"
        }
    }
}

public struct Defaults {

    public var favMatches: Set<Int> {
        get {
            AppDefaults.load(keyEncoded: .FAV_MATCH)
        }
        set {
            AppDefaults.save(items: newValue, keyEncoded: .FAV_MATCH)
        }
    }

}

public struct AppDefaults {
    
    static  func save(items: Set<Int>,keyEncoded: DefaultsKey) {
        let array = Array(items)
        UserDefaults.standard.set(array, forKey: keyEncoded.name)
    }
    
    static func load(keyEncoded: DefaultsKey) -> Set<Int> {
        let array = UserDefaults.standard.array(forKey: keyEncoded.name) as? [Int] ?? [Int]()
        return Set(array)
        
    }
    
}
