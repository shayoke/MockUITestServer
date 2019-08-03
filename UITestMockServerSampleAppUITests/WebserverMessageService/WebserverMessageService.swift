//
//  WebserverMessageService.swift
//  UITestMockServerSampleAppUITests
//
//  Created by Shayoke Mukherjee on 28/07/2019.
//  Copyright © 2019 Shayoke Mukherjee. All rights reserved.
//

import Foundation

class TestServerHost {
    public static let shared = TestServerHost()
    private init() {}
    
    func stubGETRequest(with path: String,
                        response: Data,
                        _ status: Int = 200,
                        headers: [String: String]? = nil,
                        onComplete: @escaping () -> Void) {
        
        let requestObject = StubGETRequest(path: path, response: response, status: status, headers: headers)
        sendMockserverMessage(to: StubGETRequest.mockServerMessage, instruction: requestObject, onComplete: onComplete)
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
