//
//  User.swift
//  RandomUser
//
//  Created by Jun Jung on 9/15/19.
//  Copyright © 2019 JunJung. All rights reserved.
//
import Foundation

// User Object
struct User {
    let name : Name
    
    let gender : Gender
    let location : Location
    let email : String
    
    let dob : DOB
    
    let phoneNo : String
    let cellNo : String
    
    let profilePic : ProfilePicture
    
    init(dict : JsonObj) {
        name = Name(dict: dict["name"] as! StrDict)
        gender = Gender.parse(rawValue: dict["gender"] as! String) ?? Gender.other
        location = Location(dict: dict["location"] as! JsonObj)
        
        email = dict["email"] as? String ?? ""
        
        dob = DOB(dict: dict["dob"] as! JsonObj)
        
        phoneNo = dict["phone"] as? String ?? ""
        cellNo = dict["cell"] as? String ?? ""
        
        profilePic = ProfilePicture(dict: dict["picture"] as! StrDict)
    }
}
