import UIKit

class GateCardViewController: UIViewController, UITextFieldDelegate {
    
    var scrollView =  UIScrollView()
    var contentView = UIView()
    var nameLabel = UILabel()
    var nameContainer = UIView()
    var nameField = UITextField()
    var cardLabel = UILabel()
    var cardContainer = UIView()
    var cardIcon = UIImageView()
    var cardField = UITextField()
    var expireField = UITextField()
    var cvcField = UITextField()
    var errorLabel = UILabel()
    var nameErrorLabel = UILabel()
    var button = UIButton()
    var bottomConstraint: NSLayoutConstraint?
    var buttonBottomConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = GateUi.config.texts.checkout
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)

        self.view.backgroundColor = .systemGroupedBackground
        scrollView.isUserInteractionEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.bottomConstraint = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor);
        self.bottomConstraint?.isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 15.0).isActive = true
        nameLabel.text = GateUi.config.texts.cardHolder.uppercased()
        nameLabel.font = .systemFont(ofSize: 12)
        nameLabel.textColor = .secondaryLabel
        
        nameContainer.translatesAutoresizingMaskIntoConstraints = false
//        nameContainer.backgroundColor = .white
        nameContainer.backgroundColor = .secondarySystemGroupedBackground
        contentView.addSubview(nameContainer)
        nameContainer.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8.0).isActive = true
        nameContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0).isActive = true
        nameContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0).isActive = true
        self.addBorders(nameContainer)
        
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameContainer.addSubview(nameField)
        nameField.text=""
        nameField.topAnchor.constraint(equalTo: nameContainer.topAnchor).isActive = true
        nameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0).isActive = true
        nameField.trailingAnchor.constraint(equalTo: contentView
            .trailingAnchor, constant: -15.0).isActive = true
        nameField.bottomAnchor.constraint(equalTo: nameContainer.bottomAnchor).isActive = true
        nameField.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        nameField.autocorrectionType = .no
        nameField.returnKeyType = .next
        nameField.autocapitalizationType = .words
        nameField.delegate = self
        nameField.addTarget(self, action: #selector(GateCardViewController.textFieldDidChange(_:)), for: .editingChanged)
        
        cardLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardLabel)
        cardLabel.topAnchor.constraint(equalTo: nameContainer.bottomAnchor, constant: 20.0).isActive = true
        cardLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0).isActive = true
        cardLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 15.0).isActive = true
        cardLabel.text = GateUi.config.texts.cardNumber.uppercased()
//        cardLabel.textColor = UIColor(red: 60/255.0, green: 60/255.0, blue: 67/255.0, alpha: 0.6)
        cardLabel.textColor = .secondaryLabel
        cardLabel.font = .systemFont(ofSize: 12)
        
        cardContainer.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.backgroundColor = .secondarySystemGroupedBackground
        contentView.addSubview(cardContainer)
        cardContainer.topAnchor.constraint(equalTo: cardLabel.bottomAnchor, constant: 8.0).isActive = true
        cardContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0).isActive = true
        cardContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0).isActive = true
        self.addBorders(cardContainer)
        
        cardIcon.translatesAutoresizingMaskIntoConstraints = false
        cardIcon.image = GateUi.getImage(name: "gate_credit_card")?.withRenderingMode(.alwaysTemplate)
        cardIcon.tintColor = .secondarySystemFill
        cardContainer.addSubview(cardIcon)
        cardIcon.centerYAnchor.constraint(equalTo: cardContainer.centerYAnchor).isActive = true
        cardIcon.widthAnchor.constraint(equalToConstant: 22.0).isActive = true
        cardIcon.heightAnchor.constraint(equalToConstant: 17.0).isActive = true
        cardIcon.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor, constant: 15.0).isActive = true
        
        cardField.translatesAutoresizingMaskIntoConstraints = false
        cardField.placeholder="4242 4242 4242 4242"
        cardContainer.addSubview(cardField)
        cardField.topAnchor.constraint(equalTo: cardContainer.topAnchor).isActive = true
        cardField.leadingAnchor.constraint(equalTo: cardIcon.trailingAnchor, constant: 11.0).isActive = true
        cardField.bottomAnchor.constraint(equalTo: cardContainer.bottomAnchor).isActive = true
        cardField.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        cardField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        cardField.autocorrectionType = .no
        cardField.keyboardType = .decimalPad
        cardField.returnKeyType = .next
        cardField.delegate = self
        cardField.addTarget(self, action: #selector(GateCardViewController.textFieldDidChange(_:)), for: .editingChanged)
        
        expireField.translatesAutoresizingMaskIntoConstraints = false
        expireField.placeholder=GateUi.config.texts.cardExpire
        expireField.text=""
        cardContainer.addSubview(expireField)
        expireField.topAnchor.constraint(equalTo: cardContainer.topAnchor).isActive = true
        expireField.leadingAnchor.constraint(equalTo: cardField.trailingAnchor, constant: 13.0).isActive = true
        expireField.bottomAnchor.constraint(equalTo: cardContainer.bottomAnchor).isActive = true
        expireField.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        expireField.autocorrectionType = .no
        expireField.keyboardType = .decimalPad
        expireField.returnKeyType = .next
        expireField.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        expireField.delegate = self
        expireField.addTarget(self, action: #selector(GateCardViewController.textFieldDidChange(_:)), for: .editingChanged)
        
        cvcField.translatesAutoresizingMaskIntoConstraints = false
        cvcField.placeholder=GateUi.config.texts.cardCvc
        cvcField.text=""
        cardContainer.addSubview(cvcField)
        cvcField.topAnchor.constraint(equalTo: cardContainer.topAnchor).isActive = true
        cvcField.leadingAnchor.constraint(equalTo: expireField.trailingAnchor, constant: 10.0).isActive = true
        cvcField.trailingAnchor.constraint(equalTo: cardContainer
            .trailingAnchor, constant: 0.0).isActive = true
        cvcField.bottomAnchor.constraint(equalTo: cardContainer.bottomAnchor).isActive = true
        cvcField.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        cvcField.widthAnchor.constraint(equalToConstant: 50).isActive = true
        cvcField.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        cvcField.autocorrectionType = .no
        cvcField.keyboardType = .decimalPad
        cvcField.returnKeyType = .done
        cvcField.isSecureTextEntry = true
        cvcField.delegate = self
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(errorLabel)
        errorLabel.topAnchor.constraint(equalTo: cardContainer.bottomAnchor, constant: 3.0).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 15.0).isActive = true
        errorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15.0).isActive = true
        errorLabel.text = GateUi.config.texts.cardError
        errorLabel.textColor = .systemRed
        errorLabel.font = .systemFont(ofSize: 12)
        errorLabel.isHidden = true
        
        nameErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        nameContainer.addSubview(nameErrorLabel)
        nameErrorLabel.topAnchor.constraint(equalTo: nameContainer.bottomAnchor, constant: 3.0).isActive = true
        nameErrorLabel.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor, constant: 15.0).isActive = true
        nameErrorLabel.trailingAnchor.constraint(equalTo: nameContainer.trailingAnchor, constant: 15.0).isActive = true
        nameErrorLabel.text = GateUi.config.texts.cardHolderError
        nameErrorLabel.textColor = .systemRed
        nameErrorLabel.font = .systemFont(ofSize: 12)
        nameErrorLabel.isHidden = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(GateUi.amount != nil ? String(format: "%@ %@", GateUi.config.texts.pay, GateUi.formatAmount(amount: GateUi.amount ?? 0, currency: GateUi.currency ?? "")) : GateUi.config.texts.next, for: .normal)
        view.addSubview(button)
        button.backgroundColor = GateUi.config.tintColor
        button.setTitleColor(.white, for: .normal)
        self.buttonBottomConstraint = button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0)
        self.buttonBottomConstraint?.isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 52).isActive = true
        button.layer.cornerRadius = 26
        button.addTarget(self, action: #selector(continueTapped(_:)), for: .touchUpInside)
        
//        if #available(iOS 13, *) {
//            if(UIScreen.main.traitCollection.userInterfaceStyle == .dark ){
//                self.view.backgroundColor = GateUi.config.backgroundColorDark
//                nameContainer.backgroundColor = UIColor(red: 28/255.0, green: 28/255.0, blue: 30/255.0, alpha: 1.0);
//                cardContainer.backgroundColor = UIColor(red: 28/255.0, green: 28/255.0, blue: 30/255.0, alpha: 1.0);
//                nameLabel.textColor = UIColor(red: 128/255.0, green: 133/255.0, blue: 133/255.0, alpha: 1.0);
//                cardLabel.textColor = UIColor(red: 128/255.0, green: 133/255.0, blue: 133/255.0, alpha: 1.0);
//            }
//        }
        
        self.nameField.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    @objc func keyboardWillShow(notification:NSNotification){

        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        bottomConstraint?.constant = -keyboardFrame.height
        buttonBottomConstraint?.constant = -keyboardFrame.height - 20
        self.view.layoutIfNeeded()
    }

    @objc func keyboardWillHide(notification:NSNotification){
        bottomConstraint?.constant = 0
        buttonBottomConstraint?.constant = -20
        self.view.layoutIfNeeded()
    }
    
    func addBorders(_ view: UIView) {
        let borderColor = UIColor.separator
        let topBorder = UIView()
        topBorder.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBorder)
        topBorder.backgroundColor = borderColor
        topBorder.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topBorder.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topBorder.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        let bottomBorder = UIView()
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomBorder)
        bottomBorder.backgroundColor = borderColor
        bottomBorder.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomBorder.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomBorder.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    @objc func continueTapped(_ sender: UIButton) {
        errorLabel.isHidden = true
        
        if let cardText = self.cardField.text {
            if !CCValidator.validate(creditCardNumber: cardText) {
                cardField.becomeFirstResponder()
                errorLabel.isHidden = false
                return
            }
        }
        
        if let nameText = self.nameField.text,
            nameText.count == 0 {
            nameField.becomeFirstResponder()
            errorLabel.isHidden = false
            return
        }
        
        if let expireText = self.expireField.text,
            expireText.count < 5 {
            expireField.becomeFirstResponder()
            errorLabel.isHidden = false
            return
        }
        
        if let cvcText = self.cvcField.text,
            cvcText.count < 3 {
            cvcField.becomeFirstResponder()
            errorLabel.isHidden = false
            return
        }
        
        let vc = GateWebViewController()
        vc.card = GateSdkCard(cardNumber: cardField.text ?? "", cardHolder: nameField.text ?? "", expire: expireField.text ?? "", cvc: cvcField.text ?? "")
        vc.url = GateUi.redirectUrl ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateCardIcon() {
        var icon = "gate_credit_card"
        let recognizedType = CCValidator.typeCheckingPrefixOnly(creditCardNumber: self.cardField.text ?? "")
        switch recognizedType {
        case .AmericanExpress:
            icon = "gate_card_american_express"
        case .Dankort:
            icon = "gate_card_dankort"
        case .DinersClub:
            icon = "gate_card_diners_club"
        case .Discover:
            icon = "gate_card_discover"
        case .JCB:
            icon = "gate_card_jcb"
        case .Maestro:
            icon = "gate_card_maestro"
        case .MasterCard:
            icon = "gate_card_mastercard"
        case .Mir:
            icon = "gate_card_nspk_mir"
        case .UnionPay:
            icon = "gate_card_unionpay"
        case .Visa, .VisaElectron:
            icon = "gate_card_visa"
        default:
            icon = "gate_credit_card"
        }
        self.cardIcon.image = GateUi.getImage(name: icon)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == self.expireField {
            if textField.text?.count == 5 {
                self.cvcField.becomeFirstResponder()
            }
        } else if textField == self.cardField {
            self.updateCardIcon()
        } else if textField == self.nameField {
            let regex = try! NSRegularExpression(pattern: "[^A-Za-z '.-]+", options: [])
            self.nameErrorLabel.isHidden = regex.firstMatch(in: self.nameField.text ?? "", options: [], range: NSMakeRange(0, self.nameField.text?.count ?? 0)) == nil
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == nameField
            || textField == cardField
            || textField == expireField ) {
            cardField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true;
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        
        if textField.keyboardType == .numberPad {
            if CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) {
                return false
            }
        }
        
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        if textField == nameField {
            return count <= 30
        }
        if textField == cardField {
            if count <= 23 {
                let cleanCard = textFieldText.components(separatedBy: .whitespaces).joined()
                if cleanCard.count > 0 && cleanCard.count % 4 == 0 && string.count > 0 {
                    textField.text = textFieldText + " "
                }
                return true
            }
            return false
        }
        if textField == expireField {
            if count <= 5 {
                if textFieldText.count == 0 && string.count > 0 {
                    textField.text = string == "1" || string == "0" ? string : "0" + string + "/"
                    return false
                }
                if textFieldText.count == 1 && string.count > 0 {
                    textField.text =  string == "2" || string == "1" || string == "0" ? textFieldText + string + "/" : "0" + textFieldText + "/" + string
                    return false
                }
                return true
            }
            return false
        }
        if textField == cvcField {
            return count <= 4
        }
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
