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
    }
}
