//
//  Network.swift
//  CHIPiOSIntegration
//
//  Created by CHIP.
//

import GateUi

class ApiCall {
  private var chipUrl = "https://gate.chip-in.asia/api/v1"
  private var chipSecretKey = "<<SECRETE_KEY>>"
  private var chipBrandId = "<<BRAND_ID>>"
  private var successRedirect = "https://success.com"
  private var failureRedirect = "https://failure.com"
  
  func createPurchase(_ products: [Product], client: Client, completion: @escaping (Result<GatePurchaseResponse, Error>) -> Void) {
    let urlBuilder = URLComponents(string: chipUrl+"/purchases/")

    guard let url = urlBuilder?.url else { return }

    let purchase = Purchase(products: products)
    let requestData = GatePurchaseRequest(
      client: client, purchase: purchase, brand_id: chipBrandId,
      success_redirect: successRedirect, failure_redirect: failureRedirect
    )
    let data = try! JSONEncoder().encode(requestData)
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("Bearer "+chipSecretKey, forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = data
    
    let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
      if let error = error {
        print("Error: \(error)")
        return
      }
      
      do {
        let purchase = try? JSONDecoder().decode(GatePurchaseResponse.self, from: data!)
        completion(.success(purchase!))
      } catch let error {
        completion(.failure(error.localizedDescription as! Error))
        
      }
    })
    task.resume()
  }
  
  func getPaymentMethods(completion: @escaping (Result<GateCurrencyResponse, Error>) -> Void) {
    var urlBuilder = URLComponents(string: chipUrl+"/payment_methods/")
    urlBuilder?.queryItems = [
      URLQueryItem(name: "brand_id", value: chipBrandId),
      URLQueryItem(name: "currency", value: "MYR"),
    ]

    guard let url = urlBuilder?.url else { return }

    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("Bearer "+chipSecretKey, forHTTPHeaderField: "Authorization")

    let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
      if let error = error {
        print("Error: \(error)")
        return
      }
      
      do {
        let paymentMethods = try? JSONDecoder().decode(GateCurrencyResponse.self, from: data!)
        completion(.success(paymentMethods!))
      } catch let error {
        completion(.failure(error.localizedDescription as! Error))
        
      }
    })
    task.resume()
  }
}
