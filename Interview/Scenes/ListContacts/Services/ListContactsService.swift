import Foundation

/*
 Json Contract
[
  {
    "id": 1,
    "name": "Shakira",
    "photoURL": "https://api.adorable.io/avatars/285/a1.png"
  }
]
*/

protocol ListContactServiceProtocol {
    func fetchContacts(completion: @escaping ([Contact]?, Error?) -> Void)
}

class ListContactService: ListContactServiceProtocol {
    
    private var apiURL = ""
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient, apiURL: String = "https://run.mocky.io/v3/d26d86ec-fb82-48a7-9c73-69e2cb728070"){
        self.httpClient = httpClient
        self.apiURL = apiURL
    }
    
    func fetchContacts(completion: @escaping ([Contact]?, Error?) -> Void) {
        httpClient.get(to: apiURL) { result in
            switch result {
                case .success(let jsonData):
                    do {
                        let decoder = JSONDecoder()
                        let decoded = try decoder.decode([Contact].self, from: jsonData!)
                        completion(decoded, nil)
                    } catch let error {
                        completion(nil, error)
                    }
                case .failure(let httpError):
                    completion(nil, httpError)
            }
        }
    }
}
