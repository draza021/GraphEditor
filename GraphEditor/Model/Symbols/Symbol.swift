//
//  Symbol.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 10/30/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import UIKit

final class Symbol: Symboling {
    var position: CGPoint
    var size: CGSize
    var color: UIColor
    var text: String
    
    init(with position: CGPoint, size: CGSize, color: UIColor, text: String) {
        self.position = position
        self.size = size
        self.color = color
        self.text = text
    }
    
    func getAsRectangle() -> CGRect {
        return CGRect(origin: position, size: size)
    }
}
