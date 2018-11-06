//
//  SelectionState.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 11/1/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import UIKit

class SelectionState: State {
    private var freshlySelected: Bool = false
    private var freeToAdd: Bool = true
    private lazy var graphView: GraphView? = {
       return SREG.context.graphView
    }()
    var model: Model {
        return SREG.model
    }
    var count: String {
        return String(SREG.model.symbols.count)
    }
    let selectionHandler = SelectionHandleHandler()
    
    override func stateStarted() {
        freshlySelected = false
        freeToAdd = true
    }
    
    override func tapBegan(recognizer: UITapGestureRecognizer) {
        print("Tap began -> ", recognizer.location(in: graphView))
    }
    
    override func tapChanged(recognizer: UITapGestureRecognizer) {
        print("Tap changed -> ", recognizer.location(in: graphView))
    }
    
    override func tapEnded(recognizer: UITapGestureRecognizer) {
        print("Tap ended -> ", recognizer.location(in: graphView))
        let position = recognizer.location(in: graphView)

        
        
        SREG.context.lastPosition = transformToUserSpace(point: position)
        SREG.context.symbolHit = ModelHelper.symbolAtPoint(SREG.context.lastPosition!)
        
        if SREG.selection.selection.count > 0 {  // if selection already exists
            for symbol in SREG.selection.selection {
                let handle = selectionHandler.getHandleForSymbol(symbol: symbol, point: SREG.context.lastPosition!, scale: 1)
                if handle != .none {
                    return
                }
            }
            if SREG.context.symbolHit == nil {
                freeToAdd = false
                SREG.selection.clearSelection()
                return
            }
        }
        
        if SREG.context.symbolHit != nil {
            if !SREG.selection.selection.contains(SREG.context.symbolHit!) {
                freeToAdd = false
                SREG.selection.addToSelection(symbol: SREG.context.symbolHit!)
                freshlySelected = true
            }
            return
        }
        
        if freshlySelected && SREG.context.symbolHit != nil {
            SREG.selection.removeFromSelection(symbol: SREG.context.symbolHit!)
            return
        }
        freshlySelected = false
        
        //add new symbol
        if freeToAdd {
            addNewSymbol(position)
        } else {
            freeToAdd = true
        }
    }
}

// MARK: - Private func
extension SelectionState {
    private func addNewSymbol(_ position: CGPoint) {
        let size = CGSize(width: 200, height: 100)
        
        // we would like to calculate center of a rect and have a position to calculate as a center
        let centerPoint = CGPoint(x: position.x - (size.width / 2), y: position.y - (size.height / 2))
        print("center point -> ", centerPoint)
        
        // here we create a symbol and store it in symbols array -> Model.symbols
        // we need to use Command pattern to call command to insert symbol to keep track for undo-ing
        let symbol = Symbol(with: centerPoint, size: size, color: .black, text: "Symbol # \(count)")
        model.addSymbol(symbol: symbol)
    }
}
