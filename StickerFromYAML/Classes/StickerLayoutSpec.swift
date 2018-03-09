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
        guard let left = v["left"].double,
            let right = v["right"].double,
            let up = v["up"].double,
            let down = v["down"].double
            else {return .none }
        
        return Layout(left: CGFloat(left), up: CGFloat(up), right: CGFloat(right), down: CGFloat(down))
    }
}
