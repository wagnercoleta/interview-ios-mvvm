//
//  ListContactsView.swift
//  Interview
//
//  Created by Wagner Coleta on 06/05/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation
import UIKit

final class ListContactsView: UIView {
    
    //CONSTANTS - METRICAS
    private struct Metrics {
        static let tableViewRowHeight: CGFloat = 120.0
    }
    
    //CONSTANTS - STRING
    private struct Constants {
        static let titleSelectItem = NSLocalizedString("Você tocou em", comment: "")
        static let titleSelectLegacy = NSLocalizedString("Atenção", comment: "")
        static let messageSelectLegacy = NSLocalizedString("Você tocou no contato sorteado", comment: "")
    }
    
    
    private var contacts = [Contact]()
    
    private lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        activity.startAnimating()
        return activity
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = Metrics.tableViewRowHeight
        tableView.register(ContactCell.self, forCellReuseIdentifier: String(describing: ContactCell.self))
        tableView.backgroundView = activity
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    weak var delegate: AlertView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.backgroundColor = .red
        self.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
    private func setData(data: [Contact]) {
        self.contacts = data
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activity.stopAnimating()
        }
    }
}

extension ListContactsView: ListContactsViewProtocol {
    func setData(data: [Contact]?) {
        if let contacts = data {
            self.setData(data: contacts)
        }
    }
}

extension ListContactsView:  UITableViewDataSource, UITableViewDelegate {
    
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
        
        guard contact.isLegacy else {
            delegate?.showMessage(title: Constants.titleSelectItem, message: "\(contact.name)")
            return
        }
        
        delegate?.showMessage(title: Constants.titleSelectLegacy, message: Constants.messageSelectLegacy)
    }
}
