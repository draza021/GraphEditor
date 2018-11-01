//
//  GenericContext.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 11/1/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import UIKit

protocol GenericContext {
    var lastPosition: CGPoint? { get set }
    var graphView: GraphView? { get set }
    var symbolHit: Symbol? { get set }
}
