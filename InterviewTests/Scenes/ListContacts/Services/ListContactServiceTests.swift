import XCTest
@testable import Interview

class ListContactServiceTests: XCTestCase {
    
    func test_call_fetchContacts_with_invalid_url() {
        let url = ""
        let (sut, httpClient) = makeSut(url: url)
        let exp = expectation(description: "waiting")
        var errorTemp: Error?
        sut.fetchContacts { contacts, error in
            errorTemp = error
            exp.fulfill()
        }
        httpClient.completeWithError(.InvalidURL)
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(errorTemp)
    }
    
    func test_call_fetchContacts_with_data_invalid() {
        let url = "http"
        let (sut, httpClient) = makeSut(url: url)
        let exp = expectation(description: "waiting")
        var errorTemp: Error?
        sut.fetchContacts { contatcs, error in
            errorTemp = error
            exp.fulfill()
        }
        httpClient.completeWithData(mockDataInvalid!)
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(errorTemp)
    }
    
    func test_call_fetchContacts_with_data_valid() {
        let url = "http"
        let (sut, httpClient) = makeSut(url: url)
        let exp = expectation(description: "waiting")
        var dataContacts: [Contact]?
        sut.fetchContacts { contatcs, error in
            dataContacts = contatcs
            exp.fulfill()
        }
        httpClient.completeWithData(mockData!)
        wait(for: [exp], timeout: 1)
        XCTAssertEqual(1, dataContacts!.count)
        XCTAssertEqual(2, dataContacts![0].id)
    }
}

extension ListContactServiceTests {
    func makeSut(url: String) -> (sut: ListContactService, httpClient: HttpClientMock) {
        let httpClient = HttpClientMock()
        let networkManager = NetworkManager(httpClient: httpClient)
        let sut = ListContactService(networkManager: networkManager, apiURL: url)
        return (sut, httpClient)
    }
}

var mockData: Data? {
    """
    [{
      "id": 2,
      "name": "Beyonce",
      "photoURL": "https://api.adorable.io/avatars/285/a2.png"
    }]
    """.data(using: .utf8)
}

var mockDataInvalid: Data? {
    "json-invalid".data(using: .utf8)
}
