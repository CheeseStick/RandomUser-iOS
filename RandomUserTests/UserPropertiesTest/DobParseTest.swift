//
//  DobParseTest.swift
//  RandomUserTests
//
//  Created by Jun Jung on 9/15/19.
//  Copyright © 2019 JunJung. All rights reserved.
//

import XCTest

class DobParseTest: XCTestCase {
    func testParse() {
        let rawStr = """
            {
                "date": "1975-11-12T06:34:44Z",
                "age": 42
            }
        """
        
        do {
            let jsonObj = try JSONSerialization.jsonObject(with: rawStr.data(using: .utf8)!, options: []) as! JsonObj
            let obj = DOB(dict: jsonObj)
            let cal = Calendar.current
            
            XCTAssert(cal.component(.year, from: obj.birthDate) == 1975, "Cannot parse date of birth year - " + String(cal.component(.year, from: obj.birthDate)))
            XCTAssert(cal.component(.month, from: obj.birthDate) == 11, "Cannot parse date of birth year - " + String(cal.component(.month, from: obj.birthDate)))
            XCTAssert(cal.component(.day, from: obj.birthDate) == 12, "Cannot parse date of birth year - " + String(cal.component(.day, from: obj.birthDate)))
            
            XCTAssert(obj.age == 42, "Cannot parse age - " + String(obj.age))
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
