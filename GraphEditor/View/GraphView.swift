//
//  GraphView.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 10/31/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import UIKit

class GraphView: UIView {
    var model: Model {
       return SREG.model
    }
    private var currentState: State = SelectionState()
    var elementPainters = [SymbolPainter]()
    var painter: SymbolPainter?
    let selectionHandler = SelectionHandleHandler()
    var gesture: TapBeganGesture?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("override init called")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("override init with coder called")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awake from nib called")
        setupInstance()
    }
    
    override func draw(_ rect: CGRect) {
        guard let currentContext = UIGraphicsGetCurrentContext() else { return }
        currentContext.saveGState()
        
        for painter in elementPainters {
            painter.draw(context: currentContext)
        }
        
        // draws selection handles
        selectionHandler.paintSelectionHandles(context: currentContext, selection: SREG.selection, scale: SREG.context.scale)
        
        currentContext.restoreGState()
    }
}

// MARK: - UIGestureRecognizer methods
extension GraphView {
    private func addTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tap)
    }
    
    private func addPinchGestureRecognizer() {
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        addGestureRecognizer(pinch)
    }
    
    private func addPanGestureRecognizer() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        addGestureRecognizer(pan)
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        switch gestureRecognizer.state {
        case UIGestureRecognizer.State.began:
            currentState.tapBegan(recognizer: gestureRecognizer)
            break
        case UIGestureRecognizer.State.changed:
            currentState.tapChanged(recognizer: gestureRecognizer)
            break
        case UIGestureRecognizer.State.ended, .cancelled, .failed:
            currentState.tapEnded(recognizer: gestureRecognizer)
            break
        case UIGestureRecognizer.State.possible:
            break
        }
    }
    
    @objc func handlePinch(_ gestureRecognizer: UIPinchGestureRecognizer) {
        switch gestureRecognizer.state {
        case UIGestureRecognizer.State.began:
            currentState.pinchBegan(recognizer: gestureRecognizer)
            break
        case UIGestureRecognizer.State.changed:
            currentState.pinchChanged(recognizer: gestureRecognizer)
            break
        case UIGestureRecognizer.State.ended, .cancelled, .failed:
            currentState.pinchEnded(recognizer: gestureRecognizer)
            break
        case UIGestureRecognizer.State.possible:
            break
        }
    }
    
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case UIGestureRecognizer.State.began:
            currentState.panBegan(recognizer: gestureRecognizer)
            break
        case UIGestureRecognizer.State.changed:
            currentState.panChanged(recognizer: gestureRecognizer)
            break
        case UIGestureRecognizer.State.ended, .cancelled, .failed:
            currentState.panEnded(recognizer: gestureRecognizer)
            break
        case UIGestureRecognizer.State.possible:
            break
        }
    }
    
    //since tapBegin is not called from gestureRecognizer, we have to send/simulate location from touchesBegan method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        gesture = TapBeganGesture()
        gesture?.location = touches.first?.location(in: self)
        currentState.tapBegan(recognizer: gesture!)
    }
}

extension GraphView {
    private func setupInstance() {
        addTapGestureRecognizer()
        addPinchGestureRecognizer()
        addPanGestureRecognizer()
        addObservers()
        SREG.context.graphView = self
        print("context.graphview has been SET")
    }
    
    private func addObservers() {
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(handleSymbolAddedNotification(_:)), name: NSNotification.Name.notificationSymbolAdded, object: nil)
    }
    
    @objc func handleSymbolAddedNotification(_ notification: Notification) {
        print("notificationSymbolsAdded received!")
        if let userInfo = notification.userInfo as? [String: Any] {
            if let symbols = userInfo["symbols"] as? [Symbol] {
                // what do we do with notifications?
                // for each symbol we initialize painter with symbol
                for symbol in symbols {
                    painter = PainterRectangle(symbol)
                    elementPainters.append(painter!)
                }
            }
        }
        redraw()
    }
    
    func redraw() {
        setNeedsDisplay()
        model.logSymbolsToConsole()
    }
}

class TapBeganGesture: UITapGestureRecognizer {
    var location: CGPoint?
    
    override func location(in view: UIView?) -> CGPoint {
        return self.location!
    }
}
