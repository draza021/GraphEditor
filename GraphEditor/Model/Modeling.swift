//
//  Modelable.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 10/30/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import Foundation

protocol Modeling: class {
    var symbols: [Symbol] { get set }
    func addSymbol(symbol: Symbol)
    func addSymbols(symbols: [Symbol])
    func removeSymbol(symbol: Symbol)
    func removeSymbols(symbols: [Symbol])
    func removeAllSymbols()
    func removeSelected()
    func fireModelUpdate()
}
