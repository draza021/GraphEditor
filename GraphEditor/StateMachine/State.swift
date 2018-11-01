//
//  State.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 11/1/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import UIKit

class State: GenericState {
    func stateStarted() {
        
    }
    
    func stateFinished() {
        
    }
    
    func transformToUserSpace(point: CGPoint) -> CGPoint {
        return CGPoint(x: 0, y: 0) //dummy for now
    }
    
    func tapBegan(recognizer: UITapGestureRecognizer) {
        
    }
    
    func tapChanged(recognizer: UITapGestureRecognizer) {
        
    }
    
    func tapEnded(recognizer: UITapGestureRecognizer) {
        
    }
    
    func panBegan(recognizer: UIPanGestureRecognizer) {
        
    }
    
    func panChanged(recognizer: UIPanGestureRecognizer) {
        
    }
    
    func panEnded(recognizer: UIPanGestureRecognizer) {
        
    }
    
    func pinchBegan(recognizer: UIPinchGestureRecognizer) {
        
    }
    
    func pinchChanged(recognizer: UIPinchGestureRecognizer) {
        
    }
    
    func pinchEnded(recognizer: UIPinchGestureRecognizer) {
        
    }
}
