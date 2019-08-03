//
//  Stubber.swift
//  Mockingjay
//
//  Created by Shayoke Mukherjee on 28/07/2019.
//

import Foundation
import Mockingjay

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

