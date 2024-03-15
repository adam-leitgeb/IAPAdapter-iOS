# IAPAdapter

## Overview

This Swift library provides a set of tools for managing In-App Purchases (IAP) in iOS applications. It simplifies interactions with Apple's StoreKit for product management, purchase handling, and restoring transactions.

## Requirements

- iOS 13.0 or later
- Swift 5.0 or later

## Usage

Here's an example of how to use the library, with comments explaining each step:

```swift
// Import the necessary modules
import Foundation
import StoreKit

// Define your product identifiers
let productIDs: Set<ProductIdentifier> = ["com.example.app.product1", "com.example.app.product2"]

// Initialize the IAPAdapter with your product IDs
let iapAdapter = IAPAdapterImp(productIDs: productIDs)

// Request available products from the App Store
iapAdapter.requestProducts { result in
    switch result {
    case .success(let products):
        // Handle the successful retrieval of products
        // You can now display these products in your UI and enable purchase
    case .failure(let error):
        // Handle any errors encountered during product retrieval
    }
}

// Use iapAdapter.buyProduct to initiate a purchase
// Use iapAdapter.restorePurchases to restore transactions
```

## License

This library is released under the [MIT License](LICENSE).
