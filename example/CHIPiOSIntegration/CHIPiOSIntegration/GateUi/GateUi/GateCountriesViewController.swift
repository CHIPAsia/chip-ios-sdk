import UIKit

protocol GateCountriesViewControllerDelegate {
    func countrySelected(country: String?)
}

class GateCountriesViewController: UITableViewController {
    
    var data: [(key:String,value:String)]?
    var country: String? 
    var delegate: GateCountriesViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = GateUi.config.texts.back;
        self.tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        tableView.register(GateMethodTableViewCell.self, forCellReuseIdentifier: "method")
        tableView.tableFooterView = UIView()
        self.title = GateUi.config.texts.country
        self.view.backgroundColor = .secondarySystemBackground
        self.navigationItem.leftBarButtonItem = .init(title: GateUi.config.texts.cancel, style: .plain, target: self, action: #selector(cancelTapped))
        self.data = GateUi.paymentMethods?.country_names.compactMap({(key:$0,values:$1)}).filter({ (x) -> Bool in
            return x.key != "any"
        })
        self.data?.sort (by: {
            return $0.key < $1.key
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "method") as! GateMethodTableViewCell
        cell.accessoryType = self.country == self.data?[indexPath.row].key ? .checkmark : .none
        cell.textLabel?.text = self.data?[indexPath.row].value
        cell.cardsContainer.isHidden = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.delegate?.countrySelected(country: self.data?[indexPath.row].key)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func cancelTapped(_ sender: UIButton) {
        GateUi.paymentDelegate?.paymentCanceled()
        self.navigationController?.popViewController(animated: true)
    }
}
