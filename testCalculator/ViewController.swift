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
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping : Bool = false;

    @IBAction func touchDigit(_ sender: UIButton) {
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
    
  
    
    @IBAction func performOperation(_ sender: UIButton) {
        userIsInTheMiddleOfTyping = false;

        if let mathematicalSymbol = sender.currentTitle {
            if mathematicalSymbol == "pi" {
                display.text = String(M_PI)//M_PI
            }
        }
        
    }
    
    
}

