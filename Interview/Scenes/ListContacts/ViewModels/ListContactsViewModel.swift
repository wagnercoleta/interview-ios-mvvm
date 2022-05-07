import Foundation

final class ListContactsViewModel {
    
    private struct Constans {
        static let titleError = NSLocalizedString("Ops, ocorreu um erro", comment: "")
    }
    
    private let contactService: ListContactsServiceProtocol
    private var _contacts: Observable<[Contact]> = Observable([])
    private let userIdsLegacy: UserIdsLegacyProtocol
    
    var contacts: Observable<[Contact]> {
        get { return _contacts }
    }
    
    weak var delegate: AlertView?
    
    init(contactService: ListContactsServiceProtocol,
         userIdsLegacy: UserIdsLegacyProtocol = UserIdsLegacy()){
        self.contactService = contactService
        self.userIdsLegacy = userIdsLegacy
    }
    
    private func load() {
        contactService.fetchContacts { contactResponse, error in
            if let error = error {
                self.delegate?.showMessage(title: Constans.titleError, message: error.localizedDescription)
            } else if let contacts = contactResponse {
                var lstContacts = [Contact]()
                contacts.forEach { contact in
                    let ct = Contact(id: contact.id,
                                     name: contact.name,
                                     photoURL: contact.photoURL,
                                     isLegacy: self.userIdsLegacy.isLegacy(id: contact.id))
                    lstContacts.append(ct)
                }
                self.contacts.value?.append(contentsOf: lstContacts)
            }
        }
    }
}

extension ListContactsViewModel: ListContactsViewModelProtocol {
    func loadContacts() {
        load()
    }
}
