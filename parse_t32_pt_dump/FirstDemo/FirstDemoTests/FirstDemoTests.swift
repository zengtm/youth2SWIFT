//
//  FirstDemoTests.swift
//  FirstDemoTests
//
//  Created by Thomas M Zeng on 9/4/16.
//  Copyright © 2016 Thomas M Zeng. All rights reserved.
//

import XCTest
@testable import FirstDemo

class FirstDemoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testColonDashParse() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let viewC = ViewController()
        let str = "c:0000--2000"
        
        let (rc, a, b) = viewC.colon_dash_parse(str)
        print(rc, a, b)
        
        XCTAssertEqual(rc, true, "should return true")
        XCTAssertEqual(a,0,"Start addr should be 0")
        XCTAssertEqual(b,8192,"End addr should be 4096")
    }
    

    
}
