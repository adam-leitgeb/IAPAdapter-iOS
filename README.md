# IAPAdapter

## Overview

This Swift library provides a set of tools for managing In-App Purchases (IAP) in iOS applications. It simplifies interactions with Apple's StoreKit for product management, purchase handling, and restoring transactions.

## Requirements

- iOS 13.0 or later
- Swift 5.0 or later

## Components

1. **IAPAdapter.swift**
   - Defines `IAPAdapter` protocol with essential methods for managing in-app purchases, like requesting products, making purchases, and restoring transactions.

2. **IAPAdapterImp.swift**
   - Implements the `IAPAdapter` protocol.
   - Manages the interaction with StoreKit, handling product requests, purchases, and restoration processes.

3. **IAPAdapter+Notifications.swift**
   - Extends the `IAPAdapter` with notification support.
   - Includes custom notification names for purchase events.

4. **Set+Map.swift**
   - Provides extensions to the Swift `Set` collection, introducing `setMap` and `setCompactMap` methods for easier data manipulation.

5. **ProductIdentifier.swift**
   - Simple typealias for `ProductIdentifier` to `String` for better code readability and maintenance.

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
