import UIKit

class GateMethodTableViewCell: UITableViewCell {
    
    let cardsContainer = UIStackView()
    let cards = ["gate_icon_visa", "gate_icon_mastercard", "gate_icon_maestro"]

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setup()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
        self.setup()
    }
    
    func setup() {
        cardsContainer.translatesAutoresizingMaskIntoConstraints = false
        cardsContainer.axis = .horizontal
        cardsContainer.distribution = .equalSpacing;
        cardsContainer.alignment = .center;
        cardsContainer.spacing = 5;
        self.contentView.addSubview(cardsContainer)
        
        cardsContainer.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        cardsContainer.heightAnchor.constraint(equalToConstant: 22).isActive = true
        cardsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        cards.forEach { (icon) in
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            imageView.image = GateUi.getImage(name: icon)?.withRenderingMode(.alwaysOriginal)
            imageView.heightAnchor.constraint(equalToConstant: 31).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
            cardsContainer.addArrangedSubview(imageView)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
