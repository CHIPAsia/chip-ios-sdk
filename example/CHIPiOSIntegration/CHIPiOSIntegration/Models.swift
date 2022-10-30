//
//  Purchase.swift
//  CHIPiOSIntegration
//
//  Created by CHIP.
//

import Foundation

struct Client: Codable {
  let email: String
  let full_name: String
}

struct Product: Codable {
  let name: String
  let price: Int
}

struct Purchase: Codable {
  let products: [Product]
}

struct GatePurchaseRequest: Codable {
  let client: Client
  let purchase: Purchase
  let brand_id: String
  let success_redirect: String
  let failure_redirect: String
}

struct GatePurchase: Codable {
  let total: Int
  let currency: String
}

struct GatePurchaseResponse: Codable {
  let id: String?
  let purchase: GatePurchase?
  let checkout_url: String?
  let direct_post_url: String?
  let success_redirect: String?
  let failure_redirect: String?
}
