//
//  Symbol.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 10/30/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import UIKit

protocol Symboling: class {
    var position: CGPoint { get set }
    var size: CGSize { get set }
    var color: UIColor { get set }
    var text: String { get set }
    
    init(with position: CGPoint, size: CGSize, color: UIColor, text: String)
    
    func getAsRectangle() -> CGRect
}
