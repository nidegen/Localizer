import SwiftUI
import Foundation

class BundleIdentifier {}

public extension Bundle {
  static var localizer: Bundle {
    Bundle(for: BundleIdentifier.self)
  }
}

struct Test: View {
  var body: some View {
    Text("key", tableName: "Table", bundle: .localizer, comment: "Test")
  }
}
