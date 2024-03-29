import Foundation
import StoreKit

public final class IAPAdapterImp: NSObject {

    // MARK: - Properties

    private let defaults: UserDefaults = .standard
    private let productIDs: Set<ProductIdentifier>
    private var purchasedProductIDs: Set<ProductIdentifier> = []
    private var productsRequest: SKProductsRequest?
    private var requestProductsCompletionHandler: (Result<[SKProduct], Error>) -> Void?
    private var purchaseCompletionHandler: (Result<Void, Error>) -> Void?

    // MARK: - Constructors

    public init(productIDs: Set<ProductIdentifier>) {
        self.productIDs = productIDs
        purchasedProductIDs = productIDs.setCompactMap { productID in
            let isPurchased = UserDefaults.standard.bool(forKey: productID)
            return isPurchased ? productID : nil
        }
        super.init()
        SKPaymentQueue.default().add(self)
    }
}

// MARK: - IAPAdapter

extension IAPAdapterImp: IAPAdapter {

    public func requestProducts(completionHandler: @escaping (Result<[SKProduct], Error>) -> Void) {
        productsRequest?.cancel()
        requestProductsCompletionHandler = completionHandler

        let productIdentifiers: [String] = productIDs.map { $0 }
        productsRequest = SKProductsRequest(productIdentifiers: Set(productIdentifiers))
        productsRequest?.delegate = self
        productsRequest?.start()
    }

    public func buyProduct(_ product: SKProduct, then completion: @escaping (Result<Void, Error>) -> Void) {
        print("Buying: \(product.productIdentifier)...")
        purchaseCompletionHandler = completion
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }

    public func restorePurchases(then completion: @escaping (Result<Void, Error>) -> Void) {
        purchaseCompletionHandler = completion
        SKPaymentQueue.default().restoreCompletedTransactions()
    }

    public func isProductPurchased(_ productID: ProductIdentifier) -> Bool {
        purchasedProductIDs.contains(productID)
    }
}

// MARK: - SKProductsRequestDelegate

extension IAPAdapterImp: SKProductsRequestDelegate {

    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("Loaded list of products")
        let products = response.products
        requestProductsCompletionHandler?(.success(products))
        clearRequestAndHandler()

        for p in products {
            print("Found product: \(p.productIdentifier) \(p.localizedTitle) \(p.price.floatValue)")
        }
    }

    public func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Failed to load list of products.")
        print("Error: \(error.localizedDescription)")
        requestProductsCompletionHandler?(.failure(error))
        clearRequestAndHandler()
    }

    // Helpers

    private func clearRequestAndHandler() {
        productsRequest = nil
        requestProductsCompletionHandler = nil
    }
}

// MARK: - SKPaymentTransactionObserver

extension IAPAdapterImp: SKPaymentTransactionObserver {

    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                complete(transaction: transaction)
            case .failed:
                fail(transaction: transaction)
            case .restored:
                restore(transaction: transaction)
            case .deferred, .purchasing:
                break
            @unknown default:
                break
            }
        }
    }

    // Helpers

    private func complete(transaction: SKPaymentTransaction) {
        print("Transaction complete")
        if let error = transaction.error {
            purchaseCompletionHandler?(.failure(error))
        } else {
            purchaseCompletionHandler?(.success(()))
        }
        SKPaymentQueue.default().finishTransaction(transaction)
    }

    private func restore(transaction: SKPaymentTransaction) {
        guard let productIdentifier = transaction.original?.payment.productIdentifier else {
            return
        }
        print("Restore: \(productIdentifier)")
        purchaseCompletionHandler?(.success(()))
        SKPaymentQueue.default().finishTransaction(transaction)
    }

    private func fail(transaction: SKPaymentTransaction) {
        if let error = transaction.error as NSError?, error.code != SKError.paymentCancelled.rawValue {
            purchaseCompletionHandler?(.failure(error))
        }
        SKPaymentQueue.default().finishTransaction(transaction)
    }
}
