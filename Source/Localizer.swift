//
//  Localizer.swift
//  Localizer
//
//  Created by Nicolas Degen on 24.06.18.
//  Copyright © 2018 Nicolas Degen. All rights reserved.
//

import Foundation

public class Localizer {
  
  // Localized Bundles
  public static let localizerBundle = Bundle(identifier: "com.nide.localizer")!
  public static let mainBundle = Bundle.main
  static var bundleTableHierarchy: [(bundle: Bundle, table: String?)] = [(localizerBundle, nil)]
  
  // Language override
  public static var overrideDeviceLanguage = false
  public static var useOnlyMainBundleLanguages = true
  static let deviceLocaleIdentifier = NSLocale.current.identifier
  static let preferredUserLanguages = Locale.preferredLanguages
  static let currentLanguageUserDefaultsKey = "LocalizerCurrentLanguage"
  public static var defaultLanguageIdentifier = "en"
  public static var currentLanguage: String {
    get {
        if let currentLanguage = UserDefaults.standard.object(forKey: currentLanguageUserDefaultsKey) as? String {
          return currentLanguage
        }
        return defaultLanguageIdentifier
    }
  }
  
  public static let didSwitchLanguageNotificationKey = "LocalizerLanguageChange"
  public static var onLanguageDidChangeCallbackList = [()->()]()
  
  public class func registerBundleTablePair(bundle: Bundle, table: String! = nil) {
    bundleTableHierarchy.append((bundle: bundle, table: table))
  }
  
  public class func clearRegisteredBundles() {
    bundleTableHierarchy.removeAll()
  }
  
  public class func getIdHierarchyOfBundles() -> [String] {
    var bundleIds = [String]()
    for (bundle, table) in bundleTableHierarchy {
      if let bundleId = bundle.bundleIdentifier {
        bundleIds.append(bundleId + ":" + (table ?? "Localizable"))
      }
    }
    return bundleIds
  }
  
  class func localize(key: String) -> String {
    for bundleTablePair in bundleTableHierarchy.reversed() {
      let localizedString = Localizer.localize(key: key, bundle: bundleTablePair.bundle, table: bundleTablePair.table)
      if localizedString != key {
        return localizedString
      }
    }
    return key
  }
  
  class func localize(key: String, bundle: Bundle, table:String?) -> String {
    if !overrideDeviceLanguage {
      return bundle.localizedString(forKey: key, value: nil, table: table)
    }
    if let path = bundle.path(forResource: Localizer.currentLanguage, ofType: "lproj"), let bundle = Bundle(path: path) {
      return bundle.localizedString(forKey: key, value: nil, table: table)
    } else if let path = bundle.path(forResource: "Base", ofType: "lproj"),
      let bundle = Bundle(path: path) {
      return bundle.localizedString(forKey: key, value: nil, table: table)
    }
    return key
  }
}
