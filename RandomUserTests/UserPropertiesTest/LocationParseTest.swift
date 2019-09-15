//
//  LocationParseTest.swift
//  RandomUserTests
//
//  Created by Jun Jung on 9/15/19.
//  Copyright © 2019 JunJung. All rights reserved.
//

import XCTest

class LocationParseTest: XCTestCase {
    func testParse() {
        let rawStr = """
            {
                "street": "ljan terrasse 346",
                "city": "vear",
                "state": "rogaland",
                "postcode": "3095",
                "coordinates": {
                  "latitude": "54.8646",
                  "longitude": "-97.3136"
                },
                "timezone": {
                  "offset": "-10:00",
                  "description": "Hawaii"
                }
            }
        """
        
        do {
            let jsonObj = try JSONSerialization.jsonObject(with: rawStr.data(using: .utf8)!, options: []) as! JsonObj
            let obj = Location(dict: jsonObj)

            XCTAssert(obj.street == "ljan terrasse 346", "Cannot parse street - " + String(obj.street))
            XCTAssert(obj.city == "vear", "Cannot parse city - " + String(obj.city))
            XCTAssert(obj.state == "rogaland", "Cannot parse state - " + String(obj.state))
            XCTAssert(obj.postcode == "3095", "Cannot parse postcode - " + String(obj.postcode))
            
            XCTAssert(obj.coordinates != nil, "Cannot parse coordinates")
            XCTAssert(obj.timezone != nil, "Cannot parse timezone")
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
