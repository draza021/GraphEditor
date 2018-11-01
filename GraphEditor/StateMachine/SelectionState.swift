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
    lazy var model: Model = {
        return ServiceRegistry.sharedInstance.model
    }()
    
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
        
        // original position of a tap
        let position = recognizer.location(in: graphView)
        let size = CGSize(width: 200, height: 100)
        
        // we would like to calculate center of a rect and have a position to calculate as a center
        let centerPoint = CGPoint(x: position.x - (size.width / 2), y: position.y - (size.height / 2))
        print("center point -> ", centerPoint)
        
        // here we create a symbol and store it in symbols array -> Model.symbols
        // we need to use Command pattern to call command to insert symbol to keep track for undo-ing
        let symbol = Symbol(with: centerPoint, size: size, color: .blue, text: "Default text")
        model.addSymbol(symbol: symbol)
    }
}
