import UIKit

final class ContactCell: UITableViewCell {
    
    private var contactView: ContactView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        self.contactView = ContactView(frame: .zero)
        addSubview(self.contactView)
    }
    
    private func setupConstraints() {
        self.contactView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.contactView.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.contactView.trailingAnchor.constraint(equalTo: trailingAnchor),
            self.contactView.topAnchor.constraint(equalTo: topAnchor),
            self.contactView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setup(contact: Contact){
        self.contactView.setup(contact: contact)
    }
}
