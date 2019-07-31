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
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
//    func testExample() {
//        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//        XCUIApplication().launch()
//
//
//        let app = XCUIApplication()
//        app.staticTexts["Label"].tap()
//        app.buttons["Load Posts"].tap()
//
//
//        let expectation = XCTestExpectation()
//
//        TestServerHost.shared.stubGETRequest(with: "https://jsonplaceholder.typicode.com/posts", response: ) {
//    expectation.fulfill()
//        }
//
//
//
//        wait(for: [expectation], timeout: 500)
//
//        let expectation2 = XCTestExpectation()
//        wait(for: [expectation2], timeout: 500)
//    }
    
    func testTheSecond() {

        XCUIApplication().launch()
        
        let post = Post(userId: 0, id: 0, title: "Title", body: "Body")

        // MARK: - PostRequestElement
        struct PostRequestElement: Codable {
            let userID, id: Int
            let title, body: String
            
            enum CodingKeys: String, CodingKey {
                case userID = "userId"
                case id, title, body
            }
        }
        
        typealias PostRequest = [PostRequestElement]
        
        
        let thing: PostRequest = [PostRequestElement(userID: 0, id: 0, title: "Title", body: "Body")]
        
    
        let json = try! JSONEncoder().encode(thing)

        stubGETReqeust(path: "https://jsonplaceholder.typicode.com/posts/", response: json)
        
        print("Stubbed.")
        let expectation = XCTestExpectation()
        wait(for: [expectation], timeout: 20000)
    }
    
    
    
    
}





extension XCTestCase {
    
    func stubGETReqeust(path: String, response: Data) {
        let expectationToComplete = XCTestExpectation(description: "mock server should respond")
//        https://jsonplaceholder.typicode.com/posts
        TestServerHost.shared.stubGETRequest(with: path, response: response) {
            expectationToComplete.fulfill()
        }
        
        wait(for: [expectationToComplete], timeout: 1000000)
    }
    
    
    
    
}


