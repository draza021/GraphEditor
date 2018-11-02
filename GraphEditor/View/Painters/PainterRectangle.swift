//
//  PainterRectangle.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 11/2/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import UIKit

class PainterRectangle: SymbolPainter {
    
    override func draw(context: CGContext) {
        context.saveGState()
        context.setFillColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        let ctx = ServiceRegistry.sharedInstance.context
        let point = self.symbol.position
        let transformedPosition = point.applying(ctx.transform!)
        let size = self.symbol.size
        let transformedSize = size.applying(ctx.transform!)
        
        let rect = CGRect(x: transformedPosition.x, y: transformedPosition.y, width: transformedSize.width, height: transformedSize.height)
        context.fill(rect)
        
        context.setFillColor(red: 0.2, green: 0.4, blue: 1.0, alpha: 1.0)
        let contextRect = CGRect(x: transformedPosition.x + 2, y: transformedPosition.y + 2, width: transformedSize.width - 4, height: transformedSize.height - 4)
        context.fill(contextRect)
        
        // draw text here
        
        context.restoreGState()
    }
}
