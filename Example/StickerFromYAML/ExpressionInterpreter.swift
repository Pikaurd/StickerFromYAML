//
//  ExpressionInterpreter.swift
//  StickerFromYAML_Example
//
//  Created by hirochin on 15/03/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import StickerFromYAML
import JavaScriptCore


class InterpreterProvider: ExpressionInterpreter {
    
    class var `default`: InterpreterProvider {
        struct Singleton {
            static let instance = InterpreterProvider()
        }
        return Singleton.instance
    }
    
    func interpreter() -> JSContext? {
        let context = JSContext()
        
        context?.setObject(injectTemperature(), forKeyedSubscript: "temperature" as NSString)
        
        return context
    }
    
    func injectTemperature() -> (@convention(block) () -> Int32) {
        return {
            return Int32(arc4random_uniform(40))
        }
    }
    
}
