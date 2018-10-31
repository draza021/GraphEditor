//
//  GraphView.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 10/31/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import UIKit

class GraphView: UIView {
    var model = Model()
    
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
                ctx.setFillColor(symbol.color.cgColor)
                ctx.setStrokeColor(UIColor.gray.cgColor)
                ctx.setLineWidth(5)
                ctx.addRect(symbol.getAsRectangle())
                ctx.drawPath(using: .fillStroke)
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
        let position = gestureRecognizer.location(in: self)
        let size = CGSize(width: 200, height: 100)
        let symbol = Symbol(with: position, size: size, color: .blue, text: "Default text")
        model.addSymbol(symbol: symbol)
        print("handle tap called")
        print("position: \(position)")
    }
    
    @objc func handlePinch(_ gestureRecognizer: UIPinchGestureRecognizer) {
        
    }
    
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        
    }
}

extension GraphView {
    private func setupInstance() {
        addTapGestureRecognizer()
        addPinchGestureRecognizer()
        addPanGestureRecognizer()
        addObservers()
    }
    
    private func addObservers() {
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(handleNotification(_:)), name: NSNotification.Name.notificationSymbolAdded, object: nil)
    }
    
    @objc func handleNotification(_ notification: Notification) {
        print("notificationSymbolsAdded received!")
        if let userInfo = notification.userInfo as? [String: Any] {
            if let symbol = userInfo["symbols"] as? [Symbol] {
                // do something
            }
            
        }
        redraw()
    }
    
    func redraw() {
        setNeedsDisplay()
        model.logSymbolsToConsole()
    }
}

extension Notification.Name {
    static let notificationSymbolAdded = NSNotification.Name("notificationSymbolAdded")
}
