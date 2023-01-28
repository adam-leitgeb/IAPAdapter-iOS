//
//  File.swift
//  
//
//  Created by Adam Leitgeb on 26.01.23.
//

import Foundation
import StoreKit

public protocol IAPAdapter {
    init(productIDs: Set<ProductIdentifier>)

    func requestProducts(completionHandler: @escaping RequestProductsCompletionHandler)
    func buyProduct(_ product: SKProduct, then completion: @escaping PurchaseCompletionHandler)
    func restorePurchases(then completion: @escaping PurchaseCompletionHandler)
    func isProductPurchased(_ productID: ProductIdentifier) -> Bool
}
