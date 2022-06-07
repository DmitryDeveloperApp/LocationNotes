//
//  PriceManager.swift
//  LocationNotes
//
//  Created by Dmitry Suprun on 06.06.2022.
// id из стора

import UIKit
import StoreKit


var fullVersionProduct: SKProduct?

// Нужно задать когда акаунт создам!!!!!
let idFullVersion = "id story"

class PriceManager: NSObject {
    
    func getPriceForPruduct (idProduct: String) {
        if !SKPaymentQueue.canMakePayments() {
            print("You cannot paymant")
            return
        }
        
        let request = SKProductsRequest(productIdentifiers: [idProduct])
        request.delegate = self
        request.start()
        
    }
}

extension PriceManager : SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.invalidProductIdentifiers.count != 0 {
            print("You have not actual product: \(response.invalidProductIdentifiers)")
        }
        if response.products.count > 0 {
            fullVersionProduct = response.products[0]
            print("Get product: \( fullVersionProduct?.localizedTitle) / \(fullVersionProduct?.localizedDescription)")
        }
    }
}
