import UIKit

final class ListContactsViewController: UIViewController {
    
    private struct Constants {
        static let title = NSLocalizedString("Lista de contatos", comment: "")
        static let titleOk = NSLocalizedString("Ok", comment: "")
    }
    
    private var viewProtocol: ListContactsViewProtocol
    private var viewModel: ListContactsViewModelProtocol
    
    init(viewModel: ListContactsViewModelProtocol, viewProtocol: ListContactsViewProtocol = ListContactsView()) {
        self.viewModel = viewModel
        self.viewProtocol = viewProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = viewProtocol
        view.backgroundColor = .white
        view.delegate = self
        self.view = view
        
        self.viewModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.title = Constants.title
        
        //Realiza binding para notificar a View e realizar atualização dos dados
        self.viewModel.contacts.bind({ [weak self] contacts in
            self?.viewProtocol.setData(data: contacts)
        })
        
        //Dispara atualização dos dados na ViewModel
        self.viewModel.loadContacts()
    }
}

extension ListContactsViewController: AlertView {
    func showMessage(title: String, message: String) {
        guard Thread.isMainThread else { return DispatchQueue.main.async {
            self.showMessageInternal(title: title, message: message)
        }}
        showMessageInternal(title: title, message: message)
    }
    
    private func showMessageInternal(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.titleOk, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

