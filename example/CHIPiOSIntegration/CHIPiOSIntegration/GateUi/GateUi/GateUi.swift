import UIKit

struct GateSdkCard {
    var cardNumber: String
    var cardHolder: String
    var expire: String
    var cvc: String
}

public struct GateCurrencyResponse: Decodable {
    let names: [String: String]
    let by_country: [String: [String]]
    let available_payment_methods: [String]
    let country_names: [String: String]
}

public struct GateSdkTexts {
    public var paymentMethods = [
        "card": "Bank Cards",
        "sepa_credit_transfer_qr": "SEPA Credit Transfer (QR)"
    ]
    public var paymentMethod = "Payment methods"
    public var country = "Country"
    public var payment = "Payment"
    public var cancel = "Cancel"
    public var back = "Back"
    public var checkout = "Checkout"
    public var cardHolder = "Cardholder name"
    public var cardNumber = "Card number"
    public var cardCvc = "CVC"
    public var cardExpire = "MM/YY"
    public var cardError = "Invalid card number"
    public var cardHolderError = "Please use latin letters only!"
    public var next = "Continue"
    public var done = "Done"
    public var pay = "Pay"
    public var close = "Close"
    public var successTitle = "Payment complete"
    public var successText = "Congratulations, your payment to %1$@ for %2$@ was successful!"
    public var failureTitle = "Payment failed"
    public var failureText = "Unfortunately, your payment to %1$@ failed. Please retry! "
}

public struct GateSdkConfig {
    public var backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 247/255.0, alpha: 1)
    public var backgroundColorDark = UIColor.black
    public var tintColor = UIColor(red: 52/255.0, green: 120/255.0, blue: 246/255.0, alpha: 1)
    public var successColor = UIColor(red: 30/255.0, green: 181/255.0, blue: 137/255.0, alpha: 1.0)
    public var failColor = UIColor(red: 252/255.0, green: 54/255.0, blue: 44/255.0, alpha: 1.0)
    public var merchant = "Merchant"
    public var successUrl = "http://success"
    public var failUrl = "http://fail"
    public var texts = GateSdkTexts()
}

public protocol GateSdkViewControllerDelegate {
    func paymentCompleted();
    func paymentFailed();
    func paymentCanceled();
}

public class GateUi {
    public static var config: GateSdkConfig = GateSdkConfig()
    
    public static var redirectUrl: String?
    
    public static var postUrl: String?
    
    public static var paymentDelegate: GateSdkViewControllerDelegate?
    
    public static var paymentMethods: GateCurrencyResponse?
    
    public static var amount: Int?
  
    public static var currency: String?
  
    static var zeroDecimal: [String] = ["XPF", "XOF", "XAF", "VUV", "VND", "UYI", "UGX", "RWF", "PYG", "BIF", "CLP", "CVE", "DJF", "GNF", "ISK", "JPY", "KMF", "KRW"]
    static var oneDecimal: [String] = ["MRU", "MGA"];
    static var threeDecimal: [String] = ["TND", "OMR", "LYD", "BHD", "IQD", "JOD", "KWD"];
    static var fourDecimal: [String] = ["UYW", "CLF"];
    
    public static func setup(_ redirectUrl: String, postUrl: String?, methods: GateCurrencyResponse?, amount: Int?, currency: String?) -> GateViewController {
        self.paymentMethods = methods
        self.redirectUrl = redirectUrl
        self.postUrl = postUrl
        self.amount = amount
        self.currency = currency
        return GateViewController(rootViewController: GateMethodsViewController())
    }
    
    static func getImage(name: String) -> UIImage? {
        let bundle = Bundle(for: self)
        return UIImage(named: name, in: bundle, compatibleWith: nil)
    }
  
    static func formatAmount(amount: Int, currency: String) -> String {
      
      var value = Float(amount) / 100
      if zeroDecimal.contains(currency) {
        value = Float(amount)
      } else if oneDecimal.contains(currency) {
        value = Float(amount) / 10
      } else if threeDecimal.contains(currency) {
        value = Float(amount) / 1000
      } else if fourDecimal.contains(currency) {
        value = Float(amount) / 10000
      }
      
      return String(format: "%@ %.2f", currency, value)
    }
}
