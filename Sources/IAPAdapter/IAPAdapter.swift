import Foundation
import StoreKit

public protocol IAPAdapter {
    func requestProducts(completionHandler: @escaping (Result<[SKProduct], Error>) -> Void)
    func buyProduct(_ product: SKProduct, then completion: @escaping (Result<Void, Error>) -> Void)
    func restorePurchases(then completion: @escaping (Result<Void, Error>) -> Void)
    func isProductPurchased(_ productID: ProductIdentifier) -> Bool
}
