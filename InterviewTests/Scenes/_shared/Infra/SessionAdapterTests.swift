//
//  SessionAdapterTests.swift
//  InterviewTests
//
//  Created by Wagner Coleta on 23/04/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import XCTest
@testable import Interview

class SessionAdapterTests: XCTestCase {
    
    func test_call_method_with_url_invalid() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sut = SessionAdapter(session: session)
        
        let url = ""//invalida
        UrlProtocolStub.simulate(data: nil, response: nil, error: nil)
        let exp = expectation(description: "waiting")
        sut.get(to: url) { result in
            switch result {
            case .failure(let httpError): XCTAssertEqual(httpError, HttpError.InvalidURL)
            default: XCTFail("Expected failure!")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
