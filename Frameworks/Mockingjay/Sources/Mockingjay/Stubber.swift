//
//  Stubber.swift
//  Mockingjay
//
//  Created by Shayoke Mukherjee on 28/07/2019.
//

import Foundation

public class Stubber {
  
  public init() {}
  
  @discardableResult public func stub(_ matcher: @escaping Matcher, delay: TimeInterval? = nil, _ builder: @escaping Builder) -> Stub {
    return MockingjayProtocol.addStub(matcher: matcher, delay: delay, builder: builder)
  }
  
  
  public func removeStub(_ stub:Stub) {
    MockingjayProtocol.removeStub(stub)
  }
  
  public func removeAllStubs() {
    MockingjayProtocol.removeAllStubs()
  }
  
  private func shutDown() {
    MockingjayProtocol.removeAllStubs()
  }
}


struct StubList {
  let stubs: [URLRequest: Response]
  
  
  
  
  
  
  
  
  
  
  
  
}


//public struct StubbingRequest: Codable {
//  let matcherRequest: URLRequest
//  let builderRequest: URLRequest
//  let response: Response
//
//  func performStub() {
//    Stubber().stub({
//      self.matcherRequest == $0
//    }) { if $0 == self.builderRequest { return self.response }}
//  }
//
//}
//
//public extension Stubber {
//  convenience init(stubbingRequest: StubbingRequest) {
//    self.init()
//
//  }
//}
