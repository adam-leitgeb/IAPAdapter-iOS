import Foundation

extension Set {
    func setMap<U>(transform: (Element) -> U) -> Set<U> {
        Set<U>(self.lazy.map(transform))
    }

    func setCompactMap<U>(transform: (Element) -> U?) -> Set<U> {
        Set<U>(self.lazy.compactMap(transform))
    }
}
