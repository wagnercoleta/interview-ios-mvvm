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
        let sut = makeSut()
        
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
    
    func test_call_method_with_url_valid_with_error() {
        let sut = makeSut()
        
        let url = makeUrl()
        var requestTemp: URLRequest?
        let exp = expectation(description: "waiting")
        sut.get(to: url) { result in
            
            exp.fulfill()
        }
        UrlProtocolStub.observeRequest { request in
            requestTemp = request
        }
        wait(for: [exp], timeout: 1)
        XCTAssertEqual(url, requestTemp!.url?.absoluteString)
        XCTAssertEqual("GET", requestTemp!.httpMethod)
    }
    
    func test_call_request_with_error() {
        let sut = makeSut()
        
        let url = makeUrl()
        UrlProtocolStub.simulate(data: nil, response: nil, error: makeError())
        let exp = expectation(description: "waiting")
        sut.get(to: url) { result in
            switch result {
                case .failure(let httpError): XCTAssertEqual(httpError, HttpError.request)
                default: XCTFail("Expected failure!")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
    
    func test_call_request_with_data_valid() {
        let sut = makeSut()
        
        let url = makeUrl()
        let data = makeData()
        UrlProtocolStub.simulate(data: data, response: nil, error: nil)
        let exp = expectation(description: "waiting")
        sut.get(to: url) { result in
            switch result {
                case .success(let dataReceived): XCTAssertEqual(dataReceived, data)
                default: XCTFail("Expected failure!")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}

extension SessionAdapterTests {
    func makeSut() -> SessionAdapter {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sut = SessionAdapter(session: session)
        return sut
    }
    
    func makeUrl() -> String {
        return "http://any-endpoint.com"
    }
    
    func makeError() -> Error {
        return NSError(domain: "Error", code: 0)
    }
    
    func makeData() -> Data? {
        return """
        {
            "id": 1,
            "name": "xpto"
        }
        """.data(using: .utf8)
    }
}
