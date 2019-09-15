//
//  TimezoneParseTest.swift
//  RandomUserTests
//
//  Created by Jun Jung on 9/15/19.
//  Copyright © 2019 JunJung. All rights reserved.
//

import XCTest

class TimezoneParseTest: XCTestCase {
    func testParse() {
        let rawStr = """
            {
                "offset": "-10:00",
                "description": "Hawaii"
            }
        """
        
        do {
            let jsonObj = try JSONSerialization.jsonObject(with: rawStr.data(using: .utf8)!, options: []) as! StrDict
            let timezoneObj = Timezone(dict: jsonObj)
            XCTAssert(timezoneObj.offset == "-10:00", "Cannot parse coordinates offset - " + String(timezoneObj.offset))
            XCTAssert(timezoneObj.desc == "Hawaii", "Cannot parse coordinates description" + String(timezoneObj.desc))
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
