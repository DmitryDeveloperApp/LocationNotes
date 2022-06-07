//
//  StoreManager.swift
//  LocationNotes
//
//  Created by Dmitry Suprun on 06.06.2022.
//

import UIKit
import StoreKit

class StoreManager: NSObject {

    static var isFullVersion : Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "isFull")
            UserDefaults.standard.synchronize()
        }
        get{
            UserDefaults.standard.bool(forKey: "isFull")
            
        }
    }
    
    func buyFullVarsion() {
        if let fullVersionProduct = fullVersionProduct {
            let payment = SKPayment(product: fullVersionProduct)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
        } else {
            if !SKPaymentQueue.canMakePayments() {
                print("You cannot paymant")
                return
            }
            
            let request = SKProductsRequest(productIdentifiers: [idFullVersion])
            request.delegate = self
            request.start()
        }
    }
    
    func restoreFullVersion() {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}

extension StoreManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .deferred {
                print("transaction is deferred")
            }
            if transaction.transactionState == .failed {
                print("transaction is failed")
                print("Error: \(transaction.error?.localizedDescription)")
                queue.finishTransaction(transaction)
                queue.remove(self)
            }
            if transaction.transactionState == .purchased {
                print("transaction is purchased")
                if transaction.payment.productIdentifier == idFullVersion {
                    StoreManager.isFullVersion = true
                }
                queue.finishTransaction(transaction)
                queue.remove(self)
            }
            if transaction.transactionState == .purchasing {
                print("transaction is purchasing")
            }
            if transaction.transactionState == .restored {
                print("transaction is restored")
                if transaction.payment.productIdentifier == idFullVersion {
                    StoreManager.isFullVersion = true
                }
                queue.finishTransaction(transaction)
                queue.remove(self)
                
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        
    }
}

class BuingForm {
    
    var isNeedToShow: Bool {
        if StoreManager.isFullVersion {
            return false
        }
        if notes.count <= 3 {
            return false
        }
        return true
    }
    var storeManager = StoreManager()
    
    func showForm(inController: UIViewController) {
        if let fullVersionProduct = fullVersionProduct {
            let alertController = UIAlertController(title: fullVersionProduct.localizedTitle, message: fullVersionProduct.localizedDescription, preferredStyle: UIAlertController.Style.alert )
            // сделать проверку на нил обезательно!!!
            let actionBuy = UIAlertAction(title: "Buy for \(fullVersionProduct.price) \(fullVersionProduct.priceLocale.currencySymbol!)", style: UIAlertAction.Style.default) { (alert) in
                self.storeManager.buyFullVarsion()
            }
            let actionRestore = UIAlertAction(title: "Restore", style: UIAlertAction.Style.default) { (alert) in
                self.storeManager.restoreFullVersion()
            }
            let actionCancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) { (alert) in
                
            }
            
            alertController.addAction(actionBuy)
            alertController.addAction(actionRestore)
            alertController.addAction(actionCancel)
            inController.present(alertController, animated: true, completion: nil)
            
        }
        
    }
}

extension StoreManager : SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.invalidProductIdentifiers.count != 0 {
            print("You have not actual product: \(response.invalidProductIdentifiers)")
        }
        if response.products.count > 0 {
            fullVersionProduct = response.products[0]
            print("Get product in Store Manager \( fullVersionProduct?.localizedTitle) / \(fullVersionProduct?.localizedDescription)")
            self.buyFullVarsion()
        }
    }
}
