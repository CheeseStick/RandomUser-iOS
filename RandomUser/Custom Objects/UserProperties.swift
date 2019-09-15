//
//  UserProperties.swift
//  RandomUser
//
//  Created by Jun Jung on 9/15/19.
//  Copyright © 2019 JunJung. All rights reserved.
//
import Foundation

// Name
struct Name {
    let first : String
    let last  : String
    let title : String
    
    init(dict : StrDict) {
        first = dict["first"] ?? ""
        last  = dict["last"]  ?? ""
        title = dict["title"] ?? ""
    }
}

// Gender
enum Gender : String {
    case male = "MALE"
    case female = "FEMALE"
    case other = "OTHER"
    
    static func parse(rawValue : String) -> Gender? {
        return Gender(rawValue : rawValue.uppercased())
    }
}

// Coordinates
struct Coordinates {
    let lat : Double
    let lon : Double
    
    init(dict : StrDict) {
        lat = Double(dict["latitude"] ?? "0.0")!
        lon = Double(dict["longitude"] ?? "0.0")!
    }
}

// Timezone
struct Timezone {
    let offset : String
    let desc : String
    
    init(dict : StrDict) {
        offset = dict["offset"] ?? ""
        desc = dict["description"]  ?? ""
    }
}

// Address, Coordinates and timezone
struct Location {
    let street : String
    let city : String
    let state : String
    let postcode : String
    
    let coordinates : Coordinates
    let timezone : Timezone
    
    init(dict : JsonObj) {
        street = dict["street"] as? String ?? ""
        city =   dict["city"] as? String   ?? ""
        state =  dict["state"] as? String  ?? ""
        
        postcode = dict["postcode"] as? String ?? ""
        
        coordinates = Coordinates(dict: dict["coordinates"] as! StrDict)
        timezone = Timezone(dict: dict["timezone"] as! StrDict)
    }
}

// birth and age
struct DOB {
    let birthDate : Date
    let age : UInt
    
    init(dict : JsonObj) {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss'Z'"
        
        birthDate = formatter.date(from: dict["date"] as? String ?? "") ?? Date()
        age = UInt(dict["age"] as? Int ?? 0)
    }
}

// Profile
struct ProfilePicture {
    let original : URL
    let thumbnail : URL
    
    init(dict : StrDict) {
        original = URL(string: dict["large"] ?? "")!
        thumbnail = URL(string: dict["thumbnail"] ?? "")!
    }
}
