import UIKit

class ItemTableViewCell: UITableViewCell {
    static let reuseIdentifier = "item_cell"

    var iconView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

//    var priceLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = UIColor.secondaryLabel
//        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        return label
//    }()
    
    var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.black
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    
    var currencyLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.secondaryLabel
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var lastSoldLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.secondaryLabel
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        contentView.addSubview(iconView)
        //contentView.addSubview(numberLabel)
        contentView.addSubview(iconView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(currencyLabel)
        contentView.addSubview(lastSoldLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconView.heightAnchor.constraint(equalToConstant: 30),
            iconView.widthAnchor.constraint(equalToConstant: 30),
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20)
        ])

        NSLayoutConstraint.activate([
            currencyLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            currencyLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            lastSoldLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            lastSoldLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            lastSoldLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
                iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                iconView.widthAnchor.constraint(equalToConstant: 30),
                iconView.heightAnchor.constraint(equalToConstant: 30)
            ])
    }
}
