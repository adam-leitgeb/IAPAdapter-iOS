//
//  Set+CompactMap.swift
//  tally_counter
//
//  Created by Adam Leitgeb on 22.01.23.
//  Copyright © 2023 Leitgeb. All rights reserved.
//

import Foundation

extension Set {

    func setMap<U>(transform: (Element) -> U) -> Set<U> {
        Set<U>(self.lazy.map(transform))
    }

    func setCompactMap<U>(transform: (Element) -> U?) -> Set<U> {
        Set<U>(self.lazy.compactMap(transform))
    }
}
