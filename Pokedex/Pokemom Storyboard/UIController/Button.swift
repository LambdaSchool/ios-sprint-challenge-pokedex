//
//  Button.swift
//  Pokemom Storyboard
//
//  Created by Alex Rhodes on 9/7/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit



class CoolButton: UIButton {
    var hue: CGFloat {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var saturation: CGFloat {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var brightness: CGFloat {
        didSet {
            setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.hue = 0.5
        self.saturation = 0.5
        self.brightness = 0.5
        
        super.init(coder: aDecoder)
        
        self.isOpaque = false
        self.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        var actualBrightness = brightness
        
        if state == .highlighted {
            actualBrightness -= 0.1
        }
        
        let outerColor = #colorLiteral(red: 1, green: 0, blue: 0.183686614, alpha: 1)//UIColor(hue: hue, saturation: saturation, brightness: actualBrightness, alpha: 1.0)
        let shadowColor = #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)//UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
        
        let outerMargin: CGFloat = 5.0
        let outerRect = rect.insetBy(dx: outerMargin, dy: outerMargin)
        let outerPath = createRoundedRectPath(for: outerRect, radius: 6.0)
        
        if state != .highlighted {
            context.saveGState()
            context.setFillColor(outerColor.cgColor)
            context.setShadow(offset: CGSize(width: 0, height: 2), blur: 3.0, color: shadowColor.cgColor)
            context.addPath(outerPath)
            context.fillPath()
            context.restoreGState()
        }
        
        // Outer Path Gloss & Gradient
        let outerTop = #colorLiteral(red: 1, green: 0, blue: 0.183686614, alpha: 1)//UIColor(hue: hue, saturation: saturation, brightness: actualBrightness, alpha: 1.0)
        let outerBottom = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)//UIColor(hue: hue, saturation: saturation, brightness: actualBrightness * 0.8, alpha: 1.0)
        
        context.saveGState()
        context.addPath(outerPath)
        context.clip()
        drawGlossAndGradient(context: context, rect: outerRect, startColor: outerTop.cgColor, endColor: outerBottom.cgColor)
        context.restoreGState()
        
        // Inner Path Gloss & Gradient
        let innerTop = #colorLiteral(red: 1, green: 0, blue: 0.183686614, alpha: 1)//UIColor(hue: hue, saturation: saturation, brightness: actualBrightness * 0.9, alpha: 1.0)
        let innerBottom = #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)//UIColor(hue: hue, saturation: saturation, brightness: actualBrightness * 0.7, alpha: 1.0)
        
        let innerMargin: CGFloat = 3.0
        let innerRect = outerRect.insetBy(dx: innerMargin, dy: innerMargin)
        let innerPath = createRoundedRectPath(for: innerRect, radius: 6.0)
        
        context.saveGState()
        context.addPath(innerPath)
        context.clip()
        drawGlossAndGradient(context: context, rect: innerRect, startColor: innerTop.cgColor, endColor: innerBottom.cgColor)
        context.restoreGState()
    }
    
    @objc func hesitateUpdate() {
        setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        setNeedsDisplay()
        
        perform(#selector(hesitateUpdate), with: nil, afterDelay: 0.1)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        setNeedsDisplay()
        
        perform(#selector(hesitateUpdate), with: nil, afterDelay: 0.1)
    }
}
