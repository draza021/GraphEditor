//
//  SymbolPainter.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 11/2/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import UIKit

class SymbolPainter: Hashable {
    static func == (lhs: SymbolPainter, rhs: SymbolPainter) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    let symbol: Symbol
    
    init(_ symbol: Symbol) {
        self.symbol = symbol
    }
    
    func draw(context: CGContext) {
        // abstract
    }
    
    func hash(into hasher: inout Hasher) {
        _ = hasher.finalize()
    }
}
