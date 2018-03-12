//
//  File.swift
//  FBSnapshotTestCase
//
//  Created by hirochin on 09/03/2018.
//

import Foundation
import Yaml


struct Layout {
    let left: CGFloat
    let up: CGFloat
    let right: CGFloat
    let down: CGFloat
    
    static func fromYaml(v: Yaml) -> Layout? {
        guard let left = v["left"].int,
            let right = v["right"].int,
            let up = v["up"].int,
            let down = v["down"].int
            else {return .none }
        
        return Layout(left: CGFloat(left), up: CGFloat(up), right: CGFloat(right), down: CGFloat(down))
    }
    
    static func zero() -> Layout {
        return Layout(left: 0, up: 0, right: 0, down: 0)
    }

}
