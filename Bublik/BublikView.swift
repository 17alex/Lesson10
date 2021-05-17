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
        
        shape = CAShapeLayer()
        let center = CGPoint(x: radius, y: radius)
        shape.path = UIBezierPath(arcCenter: center, radius: radius - lineWidth / 2, startAngle: 0, endAngle: 2 * .pi, clockwise: true).cgPath
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
            red: CGFloat.random(in: 0...1.0),
            green: CGFloat.random(in: 0...1.0),
            blue: CGFloat.random(in: 0...1.0),
            alpha: 1.0).cgColor
    }
        
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        let ofsetX = bounds.midX - point.x
        let ofsetY = bounds.midY - point.y
        let centerOfset = CGFloat(sqrt(Double(ofsetX * ofsetX + ofsetY * ofsetY)))
        if (centerOfset >= radius - lineWidth) && (centerOfset <= radius) {
            return view
        } else {
            return nil
        }
    }
}
