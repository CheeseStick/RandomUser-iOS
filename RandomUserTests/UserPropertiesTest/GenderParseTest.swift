//
//  GenderParseTest.swift
//  RandomUserTests
//
//  Created by Jun Jung on 9/15/19.
//  Copyright © 2019 JunJung. All rights reserved.
//

import XCTest

class GenderParseTest: XCTestCase {
    func testParse() {
        XCTAssert((Gender.parse(rawValue: "male") != nil), "Cannot parse male")
        XCTAssert((Gender.parse(rawValue: "MaLe") != nil), "Cannot parse male (Case error)")
        XCTAssert((Gender.parse(rawValue: "female") != nil), "Cannot parse female")
        XCTAssert((Gender.parse(rawValue: "FeMaLe") != nil), "Cannot parse female (Case error)")
        XCTAssert((Gender.parse(rawValue: "other") != nil), "Cannot parse other")
        XCTAssert((Gender.parse(rawValue: "OtHeR") != nil), "Cannot parse other (Case error)")
    }

    func testParsePerformance() {
        self.measure {
            testParse()
        }
    }
}
