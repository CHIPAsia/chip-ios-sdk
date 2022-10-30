import UIKit
import WebKit

class GateWebViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView?
    var url: String?
    var card: GateSdkCard?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = GateUi.config.texts.checkout
        
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        self.view.backgroundColor = GateUi.config.backgroundColor
        self.webView = WKWebView(frame: CGRect.zero, configuration: configuration);
        self.webView?.backgroundColor = GateUi.config.backgroundColor
        self.view.addSubview(self.webView!);
        if let url = URL(string: self.url ?? "") {
            if let card = card {
                self.webView?.loadHTMLString(self.getCardHtml(card, url: self.url ?? ""), baseURL: nil)
            } else {
                self.webView?.load(URLRequest(url: url));
            }
        }
        self.webView?.navigationDelegate = self;

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.webView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
    }
    
    func getCardHtml(_ card: GateSdkCard, url: String) -> String {
        return """
        <html><body onload=" ">
        <form method="POST" action="\(url)" name="card_form">
        <input type="hidden" name="card_number" value="\(card.cardNumber)" />
        <input type="hidden" name="expires" value="\(card.expire)" />
        <input type="hidden" name="cvc" value="\(card.cvc)" />
        <input type="hidden" name="cardholder_name" value="\(card.cardHolder)" />
        </form>
        <script>
        alert('test')
        window.onload = function(){ document.forms.card_form.submit();}
        </script>
        </body></html>
        """
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url?.absoluteString {
            if url.contains(GateUi.config.successUrl) {
                let vc = GateFinishViewController()
                vc.success = true
                self.navigationController?.pushViewController(vc, animated: true)
                decisionHandler(.cancel)
                return
            }
            if url.contains(GateUi.config.failUrl) {
                let vc = GateFinishViewController()
                vc.success = false
                self.navigationController?.pushViewController(vc, animated: true)
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow);
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
