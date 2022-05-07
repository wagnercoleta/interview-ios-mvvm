//
//  ContactView.swift
//  Interview
//
//  Created by Wagner Coleta on 07/05/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation
import UIKit

final class ContactView: UIView {
    
    //CONSTANTS
    private struct Metrics {
        static let labelFontSize: CGFloat = 20.0
        static let componentSpace: CGFloat = 15.0
        static let imageHeight: CGFloat = 100.0
    }
    
    private lazy var contactImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        activity.startAnimating()
        return activity
    }()
    
    private lazy var fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Metrics.labelFontSize, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        self.addSubview(contactImage)
        contactImage.addSubview(activity)
        self.addSubview(fullnameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contactImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.componentSpace),
            contactImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contactImage.heightAnchor.constraint(equalToConstant: Metrics.imageHeight),
            contactImage.widthAnchor.constraint(equalToConstant: Metrics.imageHeight),
            
            activity.centerYAnchor.constraint(equalTo: contactImage.centerYAnchor),
            activity.centerXAnchor.constraint(equalTo: contactImage.centerXAnchor),
            
            fullnameLabel.leadingAnchor.constraint(equalTo: contactImage.trailingAnchor, constant: Metrics.componentSpace),
            fullnameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.componentSpace),
            fullnameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            fullnameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setup(contact: Contact){
        fullnameLabel.text = contact.name
        
        if (contact.photoURL != ""){
            let httpClient = SessionAdapter()
            httpClient.get(to: contact.photoURL) { result in
                var dataImg: Data?
                
                switch result {
                    case .success(let data):
                        dataImg = data
                    case .failure(_):
                        dataImg = nil
                }
                
                DispatchQueue.main.async {
                    if let data = dataImg {
                        let image = UIImage(data: data)
                        self.contactImage.image = image
                    }
                    self.activity.stopAnimating()
                }
            }
        }
    }
}
