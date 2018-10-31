//
//  Model.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 10/31/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import Foundation

final class Model: GenericModel {
    var symbols: [Symbol] = []
    
    func addSymbol(symbol: Symbol) {
        symbols.append(symbol)
        fireSymbolsAdded(symbols: [symbol])
    }
    
    func addSymbols(symbols: [Symbol]) {
        self.symbols.append(contentsOf: symbols)
        fireSymbolsAdded(symbols: symbols)
    }
    
    func removeSymbol(symbol: Symbol) {
        if let index = symbols.index(where: { $0 === symbol }) {
            symbols.remove(at: index)
            fireSymbolsRemoved(symbols: [symbol])
        }
    }
    
    func removeSymbols(symbols: [Symbol]) {
        self.symbols = Array(Set(self.symbols).subtracting(symbols))
        fireSymbolsRemoved(symbols: symbols)
    }
    
    func removeAllSymbols() {
        symbols.removeAll()
        fireSymbolsRemoved(symbols: self.symbols)
    }
    
    func removeSelected() {
        // TODO: need to implement selection
    }
}

// MARK: - Notification methods
extension Model {
    func fireSymbolsAdded(symbols: [Symbol]) {
        // TODO: add notifications
    }
    
    func fireSymbolsRemoved(symbols: [Symbol]) {
        // TODO: add notifications
    }
    
    func fireModelUpdate() {
        // TODO: add notifications
    }
}
