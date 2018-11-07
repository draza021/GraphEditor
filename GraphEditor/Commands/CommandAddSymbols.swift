//
//  CommandAddSymbols.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 11/7/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import Foundation

class CommandAddSymbols: CommandAbstract {
    var symbols: [Symbol]
    
    init(symbols: [Symbol]) {
        self.symbols = symbols
    }
    
    override func doCommand() {
        SREG.selection.clearSelection()
        SREG.model.addSymbols(symbols: symbols)
    }
    
    override func undoCommand() {
        SREG.selection.clearSelection()
        SREG.model.removeSymbols(symbols: symbols)
    }
}
