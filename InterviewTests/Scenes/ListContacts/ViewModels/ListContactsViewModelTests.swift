//
//  ListContactsViewModelTests.swift
//  InterviewTests
//
//  Created by Wagner Coleta on 23/04/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import XCTest
@testable import Interview

class ListContactsViewModelTests: XCTestCase {
    
    func test_call_selectedContact_is_not_legacy() {
        let (sut, _, _) = makeSut()
        let alertView = AlertViewMock()
        sut.setAlertView(alertView: alertView)
        sut.selectedContact(contact: Contact(id: 1, name: "name", photoURL: ""))
        XCTAssertNotNil(alertView.title)
        XCTAssertNotNil(alertView.message)
    }
    
    func test_call_selectedContact_is_legacy() {
        let (sut, _, _) = makeSut()
        let alertView = AlertViewMock()
        sut.setAlertView(alertView: alertView)
        sut.selectedContact(contact: Contact(id: 10, name: "name", photoURL: ""))
        XCTAssertNotNil(alertView.title)
        XCTAssertNotNil(alertView.message)
    }
    
    func test_call_loadContacts_with_error() {
        let (sut, httpClient, service) = makeSut()
        let alertView = AlertViewMock()
        sut.setAlertView(alertView: alertView)
        let exp = expectation(description: "waiting")
        var errorTemp: Error?
        service.fetchContacts { contacts, error in
            errorTemp = error
            exp.fulfill()
        }
        httpClient.completeWithError(.InvalidURL)
        sut.loadContacts()
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(errorTemp)
    }
    
    func test_call_loadContacts_with_data() {
        let (sut, httpClient, service) = makeSut()
        let alertView = AlertViewMock()
        sut.setAlertView(alertView: alertView)
        let exp = expectation(description: "waiting")
        var dataContacts: [Contact]?
        service.fetchContacts { contacts, error in
            dataContacts = contacts
            exp.fulfill()
        }
        httpClient.completeWithData(mockData!)
        sut.loadContacts()
        wait(for: [exp], timeout: 1)
        XCTAssertEqual(1, dataContacts!.count)
    }
    
}

extension ListContactsViewModelTests {
    func makeSut() -> (sut: ListContactsViewModel, httpClient: HttpClientMock, service: ListContactService) {
        let httpClient = HttpClientMock()
        let networkManager = NetworkManager(httpClient: httpClient)
        let url = "http"
        let service = ListContactService(networkManager: networkManager, apiURL: url)
        let sut = ListContactsViewModel(contactService: service)
        return (sut, httpClient, service)
    }
}
