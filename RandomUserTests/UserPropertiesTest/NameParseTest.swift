
//
//  NameParseTest.swift
//  RandomUserTests
//
//  Created by Jun Jung on 9/15/19.
//  Copyright © 2019 JunJung. All rights reserved.
//

import XCTest

class NameParseTest: XCTestCase {
    func testParse() {
        let rawStr = """
            {
                "title": "mr",
                "first": "rolf",
                "last": "hegdal"
            }
        """
        
        do {
            let jsonObj = try JSONSerialization.jsonObject(with: rawStr.data(using: .utf8)!, options: []) as! StrDict
            let nameObj = Name(dict: jsonObj)
            XCTAssert(nameObj.title == "mr", "Cannot parse name title")
            XCTAssert(nameObj.first == "rolf", "Cannot parse name first")
            XCTAssert(nameObj.last == "hegdal", "Cannot parse name last")
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
