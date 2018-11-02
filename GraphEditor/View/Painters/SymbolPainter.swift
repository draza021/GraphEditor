//
//  SymbolPainter.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 11/2/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import UIKit

class SymbolPainter {
    let symbol: Symbol
    
    init(_ symbol: Symbol) {
        self.symbol = symbol
    }
    
    func draw(context: CGContext) {
        // abstract
    }
}
