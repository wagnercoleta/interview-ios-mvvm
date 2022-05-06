import Foundation

struct Contact: Decodable {
    let id: Int
    let name: String
    let photoURL: String
    
    /*
    --> Utilizamos apenas se a PropertyName do JSON for diferente na struct
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case photoURL = "photoURL"
        case id = "id"
    }*/
}
