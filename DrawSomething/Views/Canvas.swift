//
//  Canvas.swift
//  DrawSomething
//
//  Created by Abraham Lee on 1/5/19.
//  Copyright © 2019 Abraham Lee. All rights reserved.
//

import UIKit

// Canvas class that will let us draw
class Canvas: UIView {
    
    fileprivate var pencilWidth: Float = 1.0
    fileprivate var pencilColor: UIColor = UIColor.black
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }

        lines.forEach { (line) in
            context.setLineWidth(CGFloat(line.pencilWidth))
            context.setLineCap(.round)
            context.setStrokeColor(line.color.cgColor)
            for (i,p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }
    
    fileprivate var lines = [Line]()
    
    // Every time the user touches the screen, it makes a new line
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(color: pencilColor, pencilWidth: pencilWidth, points: []))
    }
    
    // Captures the movements
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // pop off the most recent line
        guard var line = lines.popLast() else { return }
        // gets the location of finger on the screen
        guard let point = touches.first?.location(in: nil) else { return }
        line.points.append(point)
        lines.append(line)
        
        // need this to "redraw" the screen
        setNeedsDisplay()
    }
    
    // Public functions to alter appearances
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    func resetWidth(width: Float) {
        self.pencilWidth = width
    }
    
    func changeColor(color: UIColor) {
        self.pencilColor = color
    }
}

