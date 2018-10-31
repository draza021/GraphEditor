//
//  GraphView.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 10/31/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import UIKit

class GraphView: UIView {

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
        backgroundColor = .yellow
        setupInstance()
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
    
    @objc func handleTap(_ tapGesture: UITapGestureRecognizer) {
        
    }
    
    @objc func handlePinch(_ pinchGesture: UIPinchGestureRecognizer) {
        
    }
    
    @objc func handlePan(_ panGesture: UIPanGestureRecognizer) {
        
    }
}

extension GraphView {
    private func setupInstance() {
        addTapGestureRecognizer()
        addPinchGestureRecognizer()
        addPanGestureRecognizer()
    }
}
