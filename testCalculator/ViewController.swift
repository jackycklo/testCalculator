//
//  ViewController.swift
//  testCalculator
//
//  Created by Chi kit Lo on 29/4/2017.
//  Copyright © 2017 Chi kit Lo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // ? ! both mean optional
    // ? default nil (not set)
    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping : Bool = false;
    
    private func showSizeClasses() {
        if !userIsInTheMiddleOfTyping {
            display.textAlignment = .center
//            display.text = "widht " + String(traitCollection.horizontalSizeClass.rawValue) + " height " + String(traitCollection.verticalSizeClass.rawValue)
            
            //branch
             display.text = "widht " + (traitCollection.horizontalSizeClass.description) + " height " + (traitCollection.verticalSizeClass.description)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showSizeClasses()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.showSizeClasses()
        }, completion: nil)
        
    }

    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if (userIsInTheMiddleOfTyping) {
            let textCurrentDisplay = display!.text!
            display.text = textCurrentDisplay + digit;
        } else {
            display.text = digit;
        }
        userIsInTheMiddleOfTyping = true;
        
        print("touched \(digit) digit");
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {

        if (userIsInTheMiddleOfTyping) {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false;
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathematicalSymbol)
        }
        displayValue = brain.result;
    }
    
    var savedProgram: CalculatorBrain.PropertyList?
    
    @IBAction func save() {
        savedProgram = brain.program
    }
    
    @IBAction func restore() {
        if savedProgram != nil {
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
    
}

extension UIUserInterfaceSizeClass: CustomStringConvertible {
    public var description: String {
        switch self {
        case .compact:
            return "Compact"
        case .regular:
            return "Regular"
        case .unspecified:
            return "Unspecified"
        }
    }
}

//√
//SQUARE ROOT
//Unicode: U+221A, UTF-8: E2 88 9A
