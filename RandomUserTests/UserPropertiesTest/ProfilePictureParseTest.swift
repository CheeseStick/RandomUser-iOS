//
//  ProfilePictureParseTest.swift
//  RandomUserTests
//
//  Created by Jun Jung on 9/15/19.
//  Copyright © 2019 JunJung. All rights reserved.
//

import XCTest

class ProfilePictureParseTest: XCTestCase {
    func testParse() {
        let rawStr = """
            {
                "large": "https://randomuser.me/api/portraits/men/65.jpg",
                "medium": "https://randomuser.me/api/portraits/med/men/65.jpg",
                "thumbnail": "https://randomuser.me/api/portraits/thumb/men/65.jpg"
            }
        """
        
        do {
            let jsonObj = try JSONSerialization.jsonObject(with: rawStr.data(using: .utf8)!, options: []) as! StrDict
            let obj = ProfilePicture(dict: jsonObj)

            XCTAssert(obj.original.absoluteString == "https://randomuser.me/api/portraits/men/65.jpg", "Cannot parse original profile picture URL " + obj.original.absoluteString)
            XCTAssert(obj.thumbnail.absoluteString == "https://randomuser.me/api/portraits/thumb/men/65.jpg", "Cannot parse thumbnail profile picture URL " + obj.thumbnail.absoluteString)
        } catch let parseErr {
            XCTAssert(false, "Cannot parse JSON - " + parseErr.localizedDescription)
        }
    }
    
    func testParsePerformance() {
        self.measure {
            testParse()
        }
    }
}
