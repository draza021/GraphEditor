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
       return ServiceRegistry.sharedInstance.context.graphView
    }()
    var model: Model {
        return ServiceRegistry.sharedInstance.model
    }
    var count: String {
        return String(ServiceRegistry.sharedInstance.model.symbols.count)
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

        ServiceRegistry.sharedInstance.context.lastPosition = transformToUserSpace(point: position)
        ServiceRegistry.sharedInstance.context.symbolHit = ModelHelper.symbolAtPoint(ServiceRegistry.sharedInstance.context.lastPosition!)
        
        if ServiceRegistry.sharedInstance.selection.selection.count > 0 {
            for symbol in ServiceRegistry.sharedInstance.selection.selection {
                let handle = selectionHandler.getHandleForSymbol(symbol: symbol, point: ServiceRegistry.sharedInstance.context.lastPosition!, scale: 1)
                if handle != .none {
                    return
                }
            }
            if ServiceRegistry.sharedInstance.context.symbolHit == nil {
                freeToAdd = false
                ServiceRegistry.sharedInstance.selection.clearSelection()
                return
            }
        }
        
        if ServiceRegistry.sharedInstance.context.symbolHit != nil {
            if ServiceRegistry.sharedInstance.selection.selection.contains(ServiceRegistry.sharedInstance.context.symbolHit!) {
                freeToAdd = false
                ServiceRegistry.sharedInstance.selection.addToSelection(symbol: ServiceRegistry.sharedInstance.context.symbolHit!)
                freshlySelected = true
            }
            return
        }
        
        if freshlySelected && ServiceRegistry.sharedInstance.context.symbolHit != nil {
            ServiceRegistry.sharedInstance.selection.removeFromSelection(symbol: ServiceRegistry.sharedInstance.context.symbolHit!)
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
