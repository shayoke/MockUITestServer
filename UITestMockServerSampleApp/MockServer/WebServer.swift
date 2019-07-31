//
//  WebServer.swift
//  OnDeviceServer
//
//  Created by Shayoke Mukherjee on 17/06/2019.
//  Copyright © 2019 Shayoke Mukherjee. All rights reserved.
//

import Foundation
import GCDWebServers

class WebServer {
    static var shared = WebServer()

    private let webServer = GCDWebServer()
    var ipAddress: String?
    
    private init() {}
    
    let port: UInt = 8080
    let baseURL = "localhost"
    
    static var loggingLevel: Int32 = 0 {
        didSet {
            GCDWebServer.setLogLevel(loggingLevel)
        }
    }
    
    static func startServer() {
        shared.start()
    }

    private func start() {
        WebServer.loggingLevel = 4
        
        webServer.addDefaultHandler(forMethod: "GET", request: GCDWebServerRequest.self, processBlock: defaultProcessBlock)
        webServer.addDefaultHandler(forMethod: "POST", request: GCDWebServerURLEncodedFormRequest.self, processBlock: defaultProcessBlock)

        webServer.start(withPort: port, bonjourName: "GCD Web Server")
        ipAddress = webServer.serverURL?.absoluteString ?? ""
    }
    
    private var defaultProcessBlock: GCDWebServerProcessBlock {
        return { [weak self] request in

            let path = request.path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
            
            guard let request = request as? GCDWebServerDataRequest else {
                return GCDWebServerDataResponse(text: "ERROR: Unable to parse request. Is it in the right format?")
            }
            
            if path == StubGETRequest.mockServerMessage {
                let request = try! JSONDecoder().decode(StubGETRequest.self, from: request.data)
                let result = self?.stubGETRequest(request) ?? false
                
                struct MockServerResponse: Codable {
                    let message: String
                }
                
                let reponse = MockServerResponse(message: result ? "successful" : "stub failed")
                let jsonData = try! JSONEncoder().encode(reponse)
                let json = String(data: jsonData, encoding: .utf8)!
                print(json)

                return GCDWebServerDataResponse.init(data: jsonData, contentType: "application/json")
            }
            
            return GCDWebServerDataResponse(text: "ERROR: Unable to parse path.")
        }
    }
    
    private func stubGETRequest(_ request: StubGETRequest) -> Bool {
        request.run()
        return true
    }    
}

