//
//  TestReadYaml.swift
//  StickerFromYAML_Tests
//
//  Created by hirochin on 09/03/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import Yaml

class TestReadYaml: QuickSpec {
    override func spec() {
        
        describe("read yaml") {
            let bundle = Bundle(for: type(of: self))
            let yamlUrl = bundle.url(forResource: "snowing", withExtension: "yaml")
            let s = try! String(contentsOf: yamlUrl!)
            let v = try! Yaml.load(s)
            
            expect("animation name") == v["name"].string
        }
    }
}

