//
//  UITestMockServerSampleAppUITests.swift
//  UITestMockServerSampleAppUITests
//
//  Created by Shayoke Mukherjee on 28/07/2019.
//  Copyright © 2019 Shayoke Mukherjee. All rights reserved.
//

import XCTest
import Mockingjay

class UITestMockServerSampleAppUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTheSecond() {
        struct PostRequest: Codable {
            let userId, id: Int
            let title, body: String
        }
        
        let thing: [PostRequest] = [PostRequest(userId: 0, id: 0, title: "Test Title Text", body: "Test Body Text")]
        let json = try! JSONEncoder().encode(thing)
        stubGETReqeust(path: "https://jsonplaceholder.typicode.com/posts/", response: json)
        
        let table = XCUIApplication().tables.element
        XCTAssertTrue(table.exists)
        
        let app = XCUIApplication()
        app.buttons["Load Posts"].tap()

        let tablesQuery = XCUIApplication().tables.cells
        XCTAssertTrue(tablesQuery.staticTexts["Test Title Text"].exists)
        XCTAssertTrue(tablesQuery.staticTexts["0"].exists)
        XCTAssertTrue(tablesQuery.staticTexts["Test Body Text"].exists)
    }
}


extension XCTestCase {
    func stubGETReqeust(path: String, response: Data) {
        let expectationToComplete = XCTestExpectation(description: "mock server should respond")
        TestServerHost.shared.stubGETRequest(with: path, response: response) {
            expectationToComplete.fulfill()
        }
        
        wait(for: [expectationToComplete], timeout: 10)
    }
}


