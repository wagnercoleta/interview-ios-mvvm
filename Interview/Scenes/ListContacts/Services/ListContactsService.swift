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

final class ListContactService {
    
    private var apiURL = ""
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol,
         apiURL: String = "https://run.mocky.io/v3/d26d86ec-fb82-48a7-9c73-69e2cb728070"){
        self.networkManager = networkManager
        self.apiURL = apiURL
    }
}

extension ListContactService: ListContactsServiceProtocol {
    func fetchContacts(completion: @escaping ([ContactDTO]?, Error?) -> Void) {
        networkManager.fetchNetwork(url: self.apiURL, completion: completion)
    }
}
