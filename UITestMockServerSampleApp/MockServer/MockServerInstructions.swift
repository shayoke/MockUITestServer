//
//  MockServerInstructions.swift
//  UITestMockServerSampleApp
//
//  Created by Shayoke Mukherjee on 28/07/2019.
//  Copyright © 2019 Shayoke Mukherjee. All rights reserved.
//

import Foundation
import Mockingjay

struct CodableMatcher: Codable {
    let method: String
    let uri: String
}

protocol StubRequest {
    static var mockServerMessage: String { get }
    func run()
}

struct StubGETRequest: Codable, StubRequest {
    static let mockServerMessage = "stubGETRequest"
    let path: String
    let response: Data
    let status: Int
    let headers: [String: String]?
    
    func run() {
        dump(self)
        Stubber().stub(uri(path), jsonData(response, status: status, headers: headers))
    }
}

struct StubPOSTRequest: Codable, StubRequest {
    static let mockServerMessage = "stubPOSTRequest"
    let path: String
    let response: String
    let status: Int
    let headers: [String: String]?
    
    func run() {
    }
}
