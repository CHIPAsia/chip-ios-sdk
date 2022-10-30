import UIKit

class GateFinishViewController: UIViewController {
    
    var success = false
    var container = UIView()
    var icon = UIImageView()
    var subtitleLabel = UILabel()
    var textLabel = UILabel()
    var button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = GateUi.config.texts.payment
        
        self.view.backgroundColor = .systemGroupedBackground
        
        container.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(container)
        container.widthAnchor.constraint(equalToConstant: 234).isActive = true
        container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 138).isActive = true
        container.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = GateUi.getImage(name: success ? "gate_success" : "gate_fail")?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = success ? GateUi.config.successColor : GateUi.config.failColor
        container.addSubview(icon)
        icon.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 106.0).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 106.0).isActive = true
        icon.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(subtitleLabel)
        subtitleLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 50.0).isActive = true
        subtitleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        subtitleLabel.text = success ? GateUi.config.texts.successTitle : GateUi.config.texts.failureTitle
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .label
        subtitleLabel.font = .systemFont(ofSize: 17.0)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(textLabel)
        textLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 13.0).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        textLabel.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        textLabel.numberOfLines = 0
        textLabel.text = success ? String(format: GateUi.config.texts.successText, GateUi.config.merchant, GateUi.formatAmount(amount: GateUi.amount ?? 0, currency: GateUi.currency ?? "")) : String(format: GateUi.config.texts.failureText, GateUi.config.merchant)
        textLabel.textAlignment = .center
        textLabel.textColor = .label
        textLabel.sizeToFit()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(success ? GateUi.config.texts.done : GateUi.config.texts.close, for: .normal)
        view.addSubview(button)
        button.backgroundColor = GateUi.config.tintColor
        button.setTitleColor(.white, for: .normal)
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 52).isActive = true
        button.layer.cornerRadius = 26
        button.addTarget(self, action: #selector(continueTapped(_:)), for: .touchUpInside)
        
        self.navigationItem.hidesBackButton = true
    }
    
    
    
    @objc func continueTapped(_ sender: UIButton) {
        if (success) {
            GateUi.paymentDelegate?.paymentCompleted()
        } else {
            GateUi.paymentDelegate?.paymentFailed()
        }
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
