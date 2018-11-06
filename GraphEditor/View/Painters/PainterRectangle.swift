//
//  PainterRectangle.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 11/2/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import UIKit

class PainterRectangle: SymbolPainter {
    
    // MARK: - Override method
    override func draw(context: CGContext) {
        context.saveGState()
        context.setFillColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        let ctx = SREG.context
        let point = self.symbol.position
        let transformedPosition = point.applying(ctx.transform)
        let size = self.symbol.size
        let transformedSize = size.applying(ctx.transform)
        
        let rect = CGRect(x: transformedPosition.x, y: transformedPosition.y, width: transformedSize.width, height: transformedSize.height)
        context.fill(rect)
        
        context.setFillColor(red: 0.2, green: 0.4, blue: 1.0, alpha: 1.0)
        let contextRect = CGRect(x: transformedPosition.x + 2, y: transformedPosition.y + 2, width: transformedSize.width - 4, height: transformedSize.height - 4)
        context.fill(contextRect)
        
        drawCenteredTextWithContext(context, inRectangle: contextRect)
        context.restoreGState()
    }
}

// MARK: - Private func
extension PainterRectangle {
    private func drawCenteredTextWithContext(_ context: CGContext, inRectangle contextRect: CGRect) {
        let yOffset = contextRect.origin.y + (contextRect.size.height) / 2.0 - 8
        let textRect = CGRect(x: contextRect.origin.x, y: yOffset, width: contextRect.size.width, height: contextRect.size.height)
        
        let transform = SREG.context.transform
        let textTransform = CGAffineTransform(a: transform.a, b: transform.b, c: transform.c, d: -transform.d, tx: transform.tx, ty: transform.ty)
        context.textMatrix = textTransform
        
        let text = symbol.text
        let attributedString = getAttributedString(text)
        attributedString.draw(in: textRect)
    }
    
    private func getAttributedString(_ text: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        return attributedString
    }
}
