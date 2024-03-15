import Combine
import Foundation
import StoreKit

extension IAPAdapter {

    @available(iOS 13.0, *)
    func requestProductsPublisher() -> AnyPublisher<[SKProduct], Error> {
        Future<[SKProduct], Error> { promise in
            requestProducts(completionHandler: promise)
        }
        .eraseToAnyPublisher()
    }

    @available(iOS 13.0, *)
    func buyProductPublisher(_ product: SKProduct) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            buyProduct(product, then: promise)
        }
        .eraseToAnyPublisher()
    }

    @available(iOS 13.0, *)
    func restorePurchasesPublisher() -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            restorePurchases(then: promise)
        }
        .eraseToAnyPublisher()
    }
}
