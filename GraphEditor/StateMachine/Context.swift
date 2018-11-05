//
//  Context.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 11/1/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import UIKit

class Context {
    var lastPosition: CGPoint?
    var symbolHit: Symbol?
    var graphView: GraphView?
    var scale: CGFloat
    var transform: CGAffineTransform
    var symbolIndex: Int
    
    init() {
        scale = 1.0
        transform = CGAffineTransform.identity
        symbolIndex = 1
    }
}
