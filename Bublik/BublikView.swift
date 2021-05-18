//
//  BublikView.swift
//  Bublik
//
//  Created by Alex on 17.05.2021.
//

import UIKit

final class BublikView: UIView {
    
    private let radius: CGFloat
    private let lineWidth: CGFloat
    private var shape: CAShapeLayer!
    
    init(radius: CGFloat, lineWidth: CGFloat) {
        self.radius = radius
        self.lineWidth = lineWidth
        super.init(frame: .zero)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        shape = CAShapeLayer()
        shape.path = UIBezierPath(arcCenter: CGPoint(x: radius, y: radius),
                                  radius: radius - lineWidth / 2,
                                  startAngle: 0,
                                  endAngle: 2 * .pi,
                                  clockwise: true).cgPath
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.red.cgColor
        shape.lineWidth = lineWidth
        self.layer.addSublayer(shape)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeColor() {
        shape.strokeColor = UIColor(
            red:   1.0,
            green: CGFloat.random(in: 0...0.7),
            blue:  CGFloat.random(in: 0...0.7),
            alpha: 1.0).cgColor
    }
        
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        
        if view !== self { return view }
        
        let centerOffsetX = bounds.midX - point.x
        let centerOffsetY = bounds.midY - point.y
        let offset = hypot(centerOffsetX, centerOffsetY)
        
        if (offset >= radius - lineWidth) && (offset <= radius) {
            return view
        } else {
            return nil
        }
    }
}
