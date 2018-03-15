//
//  ExpressionInterpreter.swift
//  StickerFromYAML
//
//  Created by hirochin on 15/03/2018.
//

import JavaScriptCore


public protocol ExpressionInterpreter {
    func interpreter() -> JSContext?
}
