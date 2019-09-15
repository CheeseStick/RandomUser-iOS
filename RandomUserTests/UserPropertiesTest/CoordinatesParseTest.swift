//
//  CoordinatesParseTest.swift
//  RandomUserTests
//
//  Created by Jun Jung on 9/15/19.
//  Copyright © 2019 JunJung. All rights reserved.
//

import XCTest

class CoordinatesParseTest: XCTestCase {
    func testParse() {
        let rawStr = """
            {
                "latitude": "54.8646",
                "longitude": "-97.3136"
            }
        """
        
        do {
            let jsonObj = try JSONSerialization.jsonObject(with: rawStr.data(using: .utf8)!, options: []) as! StrDict
            let coordObj = Coordinates(dict: jsonObj)
            XCTAssert(coordObj.lat == 54.8646, "Cannot parse coordinates latitude - " + String(coordObj.lat))
            XCTAssert(coordObj.lon == -97.3136, "Cannot parse coordinates longitude" + String(coordObj.lon))
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
