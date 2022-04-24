import UIKit

class ListContactsViewController: UIViewController {
    lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        activity.startAnimating()
        return activity
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        tableView.register(ContactCell.self, forCellReuseIdentifier: String(describing: ContactCell.self))
        tableView.backgroundView = activity
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    var contacts = [Contact]()
    var viewModel: ListContactsViewModelProtocol?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    init(viewModel: ListContactsViewModelProtocol){
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel!.setAlertView(alertView: self)
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        
        navigationController?.title = "Lista de contatos"
        
        //Realiza binding para notificar a View e realizar atualização dos dados
        self.viewModel?.contacts.bind({ [weak self] contacts in
            DispatchQueue.main.async {
                self?.contacts = contacts ?? [Contact]()
                self?.tableView.reloadData()
            }
        })
        
        //Dispara atualização dos dados na ViewModel
        self.viewModel?.loadContacts()
    }
    
    func configureViews() {
        view.backgroundColor = .red
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
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
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension ListContactsViewController:  UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContactCell.self), for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }
        
        let contact = contacts[indexPath.row]
        cell.setup(contact: contact)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        self.viewModel?.selectedContact(contact: contact)
    }
}

