//
//  ViewController.swift
//  CHIPiOSIntegration
//
//  Created by CHIP.
//

import UIKit
import GateUi

class ViewController: UIViewController, GateSdkViewControllerDelegate {
  private var product = Product(name: "Coffee Sido Mukti", price: 1590)
  private var client = Client(email: "test@test.com", full_name: "test buyer")
  private var paymentMethods =
    try! JSONDecoder()
      .decode(GateCurrencyResponse.self,
              from: Data(
                "{\"names\": {}, \"by_country\": {}, \"available_payment_methods\":[], \"country_names\": {}}".utf8
              ))

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    // Do any additional setup after loading the view.
    ApiCall().getPaymentMethods() {(result) in
      switch result {
        case .success(let paymentMethods):
          self.paymentMethods = paymentMethods
          print("Success")
        case .failure(_):
          print("error")
      }
    }
    
    let imageView = UIImageView.init()
    let image = UIImage(named: "sidomukti")
    imageView.image = image
    imageView.frame = CGRect(x: 10, y: 60, width: 200, height: 200)
    imageView.contentMode = UIView.ContentMode.scaleAspectFit
    imageView.layer.cornerRadius = 20
    imageView.clipsToBounds = true
    view.addSubview(imageView)
    
    let productName = UILabel(frame: CGRect(x: 220, y: 60, width: 150, height: 40))
    productName.text = "Coffee SidoMukti"
    view.addSubview(productName)
    
    let price = UILabel(frame: CGRect(x: 220, y: 90, width: 150, height: 40))
    price.text = "Price: RM15.90"
    view.addSubview(price)
    
    let button = UIButton(frame: CGRect(x: 220, y: 200, width: 100, height: 40))
    button.layer.cornerRadius = 10
    button.backgroundColor = .systemBlue
    button.setTitle("Buy Now", for: [])
    button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    view.addSubview(button)
  }
  
  @objc func buttonAction(sender: UIButton!) {
    var products = [Product]()
    products.append(product)
    ApiCall().createPurchase(products, client: client) {(result) in
      switch result {
      case .success(let purchase):
        DispatchQueue.main.async {
          Payment()
            .createPayment(self, purchase: purchase, paymentMethods: self.paymentMethods)
        }
      case .failure(_):
        print("error")
      }
    }
  }

  func paymentCompleted() {
    print("completed")
  }
  
  func paymentFailed() {
    print("failed")
  }
  
  func paymentCanceled() {
    print("canceled")
  }

}

