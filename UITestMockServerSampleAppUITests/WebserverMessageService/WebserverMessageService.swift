//
//  WebserverMessageService.swift
//  UITestMockServerSampleAppUITests
//
//  Created by Shayoke Mukherjee on 28/07/2019.
//  Copyright © 2019 Shayoke Mukherjee. All rights reserved.
//

import Foundation

class TestServerHost {
    static let shared = TestServerHost()
    
    private init() {}
    
    public func startStubServer(onComplete: @escaping () -> Void) {
        
    }
    
    public func stopStubServer(onComplete: @escaping () -> Void) {
        
    }
    
    func stubGETRequest(with path: String,
                        response: Data,
                        _ status: Int = 200,
                        headers: [String: String]? = nil,
                        onComplete: @escaping () -> Void) {
        
        let requestObject = StubGETRequest(path: path, response: response, status: status, headers: headers)
        sendMockserverMessage(to: StubGETRequest.mockServerMessage, instruction: requestObject, onComplete: onComplete)
    }
    
    func stubRequests(with path: String, error: Error, onComplete: @escaping () -> Void) {
        
    }
    
    func killNetwork(onComplete: @escaping () -> Void) {
        
    }
    
    func reviveNetwork(onComplete: @escaping () -> Void) {
        
    }
    
    
    func sendMockserverMessage<T: Encodable>(to path: String, instruction: T, onComplete: @escaping () -> Void) {
        var components = URLComponents()
        components.scheme = "http"
        components.port = 8080
        components.host = "localhost"
        components.path = "/\(path)/"
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try! JSONEncoder().encode(instruction)
        
        let task = URLSession.shared.dataTask(with: request) { _, _, _ in
            onComplete()
        }
        
        task.resume()
    }
}
