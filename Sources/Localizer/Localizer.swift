import SwiftUI
import Foundation

class BundleIdentifier {}

public extension Bundle {
  static var localizer: Bundle {
    Bundle.module
  }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, macCatalyst 13, *)
public extension Text {
  init(localized key: LocalizedStringKey) {
    self.init(key, bundle: .localizer)
  }
}

public extension String {
  func localized() -> String {
    NSLocalizedString(self, bundle: .localizer, comment: self)
  }
  
  func localize(forBundle bundle: Bundle = .localizer, table: String? = nil, comment: String? = nil) -> String {
    NSLocalizedString(self, tableName: table, bundle: bundle, comment: comment ?? self)
  }
}
