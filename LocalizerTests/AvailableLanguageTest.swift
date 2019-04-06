//
//  AvailableLanguageTest.swift
//  LocalizerTests
//
//  Created by Nicolas Degen on 04.10.18.
//  Copyright © 2018 Nicolas Degen. All rights reserved.
//

import XCTest

import Localizer

class AvailableLanguageTest: XCTestCase {
  
  override func setUp() {
//    Localizer.registerBundleTablePair(bundle: Bundle(identifier: "com.nide.localizer"))
    Localizer.registerBundleTablePair(bundle: Bundle(for: type(of: self)))
//    Localizer.registerBundleTablePair(bundle: Bundle(for: type(of: self)), table: "Additional")
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testAvailableLanguages() {
    let availableLanguages = Localizer.availableLanguages(excludeBase: false, forBundle: Bundle(for: type(of: self)))
    for lang in availableLanguages {
      print(lang)
    }
    XCTAssert(availableLanguages.count == 8)
  }  
}
