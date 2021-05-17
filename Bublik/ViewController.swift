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

class ViewController: UIViewController {
    
    lazy var bublik: BublikView = {
        let bublik = BublikView(radius: 75, lineWidth: 30)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(bublikPress))
        bublik.addGestureRecognizer(tapGesture)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(gesture:)))
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
    
    var pointBublik: CGPoint = .zero
    
    //MARK: - Metods
    
    @objc private func panGesture(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            pointBublik = bublik.frame.origin
        }
        
        let location = gesture.translation(in: button)
        bublik.frame.origin = .init(x: pointBublik.x + location.x, y: pointBublik.y + location.y)
    }
    
    @objc private func buttonPress() {
        print("press button")
    }
    
    @objc private func bublikPress() {
        print("BUBLIK press")
        bublik.changeColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9181670368, green: 0.9181670368, blue: 0.9181670368, alpha: 1)
        
        view.addSubview(button)
        view.addSubview(bublik)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        button.frame.size = .init(width: 250, height: 250)
        button.center = view.center
        
        bublik.frame.size = .init(width: 150, height: 150)
        bublik.center = view.center
    }
}
