import UIKit

class GateMethodsViewController: UITableViewController, GateCountriesViewControllerDelegate {
    
    let cardMethods = ["card", "ecomm", "maestro", "mastercard", "visa"]
    
    var data: [(key:String,values:[String])]?
    
    var country: String?
    
    var showSelection = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = GateUi.config.texts.back;
        self.tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        tableView.register(GateMethodTableViewCell.self, forCellReuseIdentifier: "method")
        tableView.tableFooterView = UIView()
        self.title = GateUi.config.texts.checkout
        self.view.backgroundColor = .secondarySystemBackground
        self.navigationItem.leftBarButtonItem = .init(title: GateUi.config.texts.cancel, style: .plain, target: self, action: #selector(cancelTapped))
        self.country = Locale.current.regionCode
        self.data = GateUi.paymentMethods?.by_country.compactMap({(key:$0,values:$1)})
        self.data?.sort (by: {
            if $0.key == "any" {
                return false
            }
            if $1.key == "any" {
                return true
            }
            return $0.key < $1.key
        })
        if GateUi.paymentMethods?.by_country[self.country ?? ""] == nil {
            self.country = self.data?.first?.key
        }
        showSelection = data?.count ?? 0 > 1
        if  GateUi.paymentMethods?.country_names["any"] != nil  {
            showSelection = data?.count ?? 0 > 2
        }
        self.tableView.contentInset = UIEdgeInsets(top: !showSelection ? -44 : 0, left: 0, bottom: 0, right: 0)
        
//        if #available(iOS 13, *) {
//            if(UIScreen.main.traitCollection.userInterfaceStyle == .dark ){
//                self.view.backgroundColor = GateUi.config.backgroundColorDark
//            }
//        }
        // Do any additional setup after loading the view.
    }
    
    func methods(country: String?) -> [String]? {
        var methods = GateUi.paymentMethods?.by_country[country ?? ""]
        if country != "any" {
            methods?.append(contentsOf: GateUi.paymentMethods?.by_country["any"] ?? [])
        }
        return methods
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        }
        return GateUi.config.texts.paymentMethod
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return showSelection ? 1 : 0
        }
        return methods(country: country)?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "method") as! GateMethodTableViewCell
        if indexPath.section == 0 {
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = GateUi.config.texts.country 
            cell.cardsContainer.isHidden = true
            cell.detailTextLabel?.text = GateUi.paymentMethods?.country_names[country ?? ""]
            return cell
        }
        if let method = methods(country: country)?[indexPath.row] {
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = GateUi.paymentMethods?.names[method] ?? method
            cell.cardsContainer.isHidden = !self.cardMethods.contains(method)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            let vc = GateCountriesViewController()
            vc.delegate = self
            vc.country = self.country
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        if let method = methods(country: country)?[indexPath.row] {
            if self.cardMethods.contains(method),
                GateUi.postUrl != nil {
                self.navigationController?.pushViewController(GateCardViewController(), animated: true)
            } else {
                let vc = GateWebViewController()
                vc.url = GateUi.redirectUrl?.appending("?preferred=" + method) ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @objc func cancelTapped(_ sender: UIButton) {
        GateUi.paymentDelegate?.paymentCanceled()
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func countrySelected(country: String?) {
        self.country = country
        self.tableView.reloadData()
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
