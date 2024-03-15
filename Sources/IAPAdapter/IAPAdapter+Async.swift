import Foundation
import StoreKit

extension IAPAdapter {

    @available(iOS 13.0, *)
    func requestProducts() async throws -> [SKProduct] {
        try await withCheckedThrowingContinuation { continuation in
            requestProducts(completionHandler: continuation.resume)
        }
    }

    @available(iOS 13.0, *)
    func buyProduct(_ product: SKProduct) async throws {
        try await withCheckedThrowingContinuation { continuation in
            buyProduct(product) { continuation.resume(with: $0) }
        }
    }

    @available(iOS 13.0, *)
    func restorePurchases() async throws {
        try await withCheckedThrowingContinuation { continuation in
            restorePurchases { continuation.resume(with: $0) }
        }
    }
}
