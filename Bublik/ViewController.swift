//
//  ViewController.swift
//  Bublik
//
//  Created by Алексей Алексеев on 15.05.2021.
//

//ДЗ:
//Реализовать в проекте UIKitLesson Бублик с прозрачным центром.
//По нажатию но прозрачный центр прокидывать евент nextResponder (hitTest, pointInside).
//Внутри бублика (под ним в иерархии) кнопка ViewController2

import UIKit

final class ViewController: UIViewController {
    
    lazy var sameView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sameViewPress))
        view.addGestureRecognizer(tapGesture)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(sameViewPan(gesture:)))
        view.addGestureRecognizer(panGesture)
        return view
    }()
    
    lazy var bublik: BublikView = {
        let bublik = BublikView(radius: 75, lineWidth: 30)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(bublikPress))
        bublik.addGestureRecognizer(tapGesture)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(bublikPan(gesture:)))
        bublik.addGestureRecognizer(panGesture)
        return bublik
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Button", for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        return button
    }()
    
    private var pointBublik: CGPoint = .zero
    private var pointSameView: CGPoint = .zero
    private var scaleBublik: CGFloat = 1
    
    //MARK: - Metods gesture
    
    @objc private func bublikPan(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            pointBublik = bublik.frame.origin
        }
        
        let location = gesture.translation(in: button)
        bublik.frame.origin = .init(x: pointBublik.x + location.x, y: pointBublik.y + location.y)
    }
    
    @objc private func sameViewPan(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            pointSameView = sameView.frame.origin
        }
        
        let location = gesture.translation(in: button)
        sameView.frame.origin = .init(x: pointSameView.x + location.x, y: pointSameView.y + location.y)
    }
    
    //MARK: - Metods
    
    @objc private func buttonPress() {
        print("press button")
        button.backgroundColor = UIColor(
            red:   CGFloat.random(in: 0...1.0),
            green: 1.0,
            blue:  CGFloat.random(in: 0...1.0),
            alpha: 1.0)
    }
    
    @objc private func bublikPress() {
        print("🥯 BUBLIK press")
        bublik.changeColor()
    }
    
    @objc private func sameViewPress() {
        print("sameView press")
        sameView.backgroundColor = UIColor(
            red:   CGFloat.random(in: 0...1.0),
            green: CGFloat.random(in: 0...1.0),
            blue:  1.0,
            alpha: 1.0)
    }
    
    //MARK: - LiveCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9181670368, green: 0.9181670368, blue: 0.9181670368, alpha: 1)
        
        view.addSubview(button)
        view.addSubview(bublik)
        bublik.addSubview(sameView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        button.frame.size = .init(width: 250, height: 250)
        button.center = view.center
        
        bublik.frame.size = .init(width: 150, height: 150)
        bublik.center = view.center
        
        sameView.frame = .init(x: 10, y: 10, width: 100, height: 100)
    }
}
