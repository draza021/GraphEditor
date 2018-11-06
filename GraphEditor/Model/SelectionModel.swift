//
//  SelectionModel.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 11/5/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import Foundation

class SelectionModel {
    var selection = [Symbol]()
    
    func addToSelection(symbol: Symbol) {
        selection.append(symbol)
        fireSelectionChanged(symbols: [symbol])
    }
    
    func addMultipleSelection(symbols: [Symbol]) {
        for symbol in symbols {
            if !selection.contains(symbol) {
                selection.append(symbol)
            }
        }
        fireSelectionChanged(symbols: symbols)
    }
    
    func removeFromSelection(symbol: Symbol) {
        if let index = selection.index(where: { $0 === symbol }) {
            selection.remove(at: index)
            fireSelectionChanged(symbols: [])
        }
    }
    
    func clearSelection() {
        selection.removeAll()
        fireSelectionChanged(symbols: [])
    }
}

extension SelectionModel {
    private func fireSelectionChanged(symbols: [Symbol]) {
        let nc = NotificationCenter.default
        nc.post(name: .notificationSelectionChanged, object: nil, userInfo: ["symbols": symbols])
        print("notificationSelectionChanged fired!")
    }
}
