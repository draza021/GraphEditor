//
//  GraphView.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 10/31/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import UIKit

class GraphView: UIView {
    lazy var model: Model = {
       return ServiceRegistry.sharedInstance.model
    }()
    private var currentState: State = SelectionState()
    
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
        if !model.symbols.isEmpty {
            guard let ctx = UIGraphicsGetCurrentContext() else { return }
            model.symbols.forEach { (symbol) in
                let nsattributedString = createAttributedString(symbol)
                ctx.setFillColor(symbol.color.cgColor)
                ctx.setStrokeColor(UIColor.gray.cgColor)
                ctx.setLineWidth(5)
                let rect = symbol.getAsRectangle()
                nsattributedString.draw(in: rect)
                ctx.addRect(rect)
                ctx.drawPath(using: .stroke)
            }
        }
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
}

extension GraphView {
    private func setupInstance() {
        addTapGestureRecognizer()
        addPinchGestureRecognizer()
        addPanGestureRecognizer()
        addObservers()
        ServiceRegistry.sharedInstance.context.graphView = self
        print("context.graphview has been SET")
    }
    
    private func addObservers() {
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(handleNotification(_:)), name: NSNotification.Name.notificationSymbolAdded, object: nil)
    }
    
    @objc func handleNotification(_ notification: Notification) {
        print("notificationSymbolsAdded received!")
        if let userInfo = notification.userInfo as? [String: Any] {
            if let symbol = userInfo["symbols"] as? [Symbol] {
                // what do we do with notifications?
            }
        }
        redraw()
    }
    
    func redraw() {
        setNeedsDisplay()
        model.logSymbolsToConsole()
    }
    
    private func createAttributedString(_ symbol: Symbol) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0),
            NSAttributedString.Key.foregroundColor: UIColor.blue
        ]
        
        guard let index = model.symbols.index(where: { $0 === symbol }) else { fatalError() }
        let myText = "Symbol # \(index)"
        let attributedString = NSAttributedString(string: myText, attributes: attributes)
        return attributedString
    }
}


