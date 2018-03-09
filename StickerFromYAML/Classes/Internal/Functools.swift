//
//  Functools.swift
//  StickerFromYAML
//
//  Created by hirochin on 09/03/2018.
//

import Foundation

internal func tabulate<A>(times: Int, f: (Int) -> A) -> [A] {
    return Array(0..<times).map(f)
}
