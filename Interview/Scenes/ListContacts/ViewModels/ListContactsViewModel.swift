import Foundation

protocol ListContactsViewModelProtocol {
    func setAlertView(alertView: AlertView)
    var contacts: Observable<[Contact]> { get }
    func selectedContact(contact: Contact)
    func loadContacts()
}

class ListContactsViewModel: ListContactsViewModelProtocol {
    
    private var alertView: AlertView?
    private let contactService: ListContactServiceProtocol
    private var _contacts: Observable<[Contact]> = Observable([])
    var contacts: Observable<[Contact]> {
        get { return _contacts }
    }
    
    init(contactService: ListContactServiceProtocol){
        self.contactService = contactService
    }
    
    func setAlertView(alertView: AlertView) {
        self.alertView = alertView
    }
    
    func selectedContact(contact: Contact) {
        let isLegacy = UserIdsLegacy.isLegacy(id: contact.id)
        if (!isLegacy){
            self.alertView?.showMessage(title: "Você tocou em", message: "\(contact.name)")
        } else {
            self.alertView?.showMessage(title: "Atenção", message: "Você tocou no contato sorteado")
        }
    }
    
    func loadContacts() {
        contactService.fetchContacts { contacts, error in
            if let error = error {
                self.alertView?.showMessage(title: "Ops, ocorreu um erro", message: error.localizedDescription)
            } else if let contacts = contacts {
                self.contacts.value?.append(contentsOf: contacts)
            }
        }
    }
}
