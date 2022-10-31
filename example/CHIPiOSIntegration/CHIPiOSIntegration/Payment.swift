import GateUi
import UIKit

class Payment: GateSdkViewControllerDelegate {
  func createPayment(
    _ view: UIViewController,
    purchase: GatePurchaseResponse, // response from POST /purchases/
    paymentMethods: GateCurrencyResponse // response from GET /payment_methods/
  ) {
    // Enter your company name to display in Payment process
    GateUi.config.merchant = "CHIP Demo Merchant"

    // make sure you pass this on POST /purchases/ payload
    GateUi.config.successUrl = purchase.success_redirect!

    // make sure you pass this on POST /purchases/ payload
    GateUi.config.failUrl = purchase.failure_redirect!

    let vc = GateUi.setup(
      purchase.checkout_url!,
      postUrl: purchase.direct_post_url,
      methods: paymentMethods,
      amount: purchase.purchase?.total,
      currency: purchase.purchase?.currency
    )

    // class have to conform to GateSdkViewControllerDelegate protocol
    GateUi.paymentDelegate = view as? any GateSdkViewControllerDelegate
    vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
    view.present(vc, animated: true, completion: nil)
  }
  
  func paymentCompleted() {
    print("Payment Completed")
  }
  
  func paymentFailed() {
    print("Payment Failed")
  }
  
  func paymentCanceled() {
    print("Payment Canceled")
  }
}

