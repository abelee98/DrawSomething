//
//  ViewController.swift
//  DrawSomething
//
//  Created by Abraham Lee on 1/5/19.
//  Copyright © 2019 Abraham Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let canvas = Canvas()
    
    let undo: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Undo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleUndo() {
        canvas.undo()
    }
    
    let clear: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleClear() {
        canvas.clear()
    }
    
    let pencilWidth: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.addTarget(self, action: #selector(handleWidth), for: .valueChanged)
        return slider
    }()
    
    @objc fileprivate func handleWidth(sender: UISlider) {
        print(sender.value)
        canvas.resetWidth(width: sender.value)
    }
    
    let yellowButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.yellow
        button.layer.borderWidth = 1.0
        button.addTarget(self, action: #selector(handleColor), for: .touchUpInside)
        return button
    }()
    
    let redButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        button.layer.borderWidth = 1.0
        button.addTarget(self, action: #selector(handleColor), for: .touchUpInside)
        return button
    }()
    
    let blueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.layer.borderWidth = 1.0
        button.addTarget(self, action: #selector(handleColor), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleColor(button: UIButton) {
        guard let color = button.backgroundColor else { return }
        canvas.changeColor(color: color)
    }

    // set the original view to be the canvas instead of the white original
    override func loadView() {
        self.view = canvas
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        canvas.backgroundColor = UIColor.white
        
        setupStack()
    }

    func setupStack() {
        let colorStack = UIStackView(arrangedSubviews: [yellowButton, redButton, blueButton])
        colorStack.distribution = .fillEqually
        let stack = UIStackView(arrangedSubviews: [undo, clear, colorStack, pencilWidth])
        stack.distribution = .fillEqually
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

}

