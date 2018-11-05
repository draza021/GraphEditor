//
//  ModelHelper.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 11/5/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import UIKit

class ModelHelper {
    static func symbolAtPoint(_ point: CGPoint) -> Symbol? {
        if let painters = ServiceRegistry.sharedInstance.context.graphView?.elementPainters {
            for (key, _) in painters.enumerated() {
                let symbol = painters[key].symbol
                if symbol.getAsRectangle().contains(point) {
                    return symbol
                }
            }
        }
        return nil
    }
}
