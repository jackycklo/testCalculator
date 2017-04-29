//
//  CalculatorBrain.swift
//  testCalculator
//
//  Created by Chi kit Lo on 29/4/2017.
//  Copyright © 2017 Chi kit Lo. All rights reserved.
//

import Foundation

//enum Optional<T> {
//    case None
//    case Some(T)
//}
//
//func multiply(op1: Double, op2: Double) -> Double {
//    return op1 * op2;
//}

class CalculatorBrain
{
    private var accumulator = 0.0
    private var internalProgram = [AnyObject]()
    
    
    func setOperand(operand: Double)  {
        accumulator = operand;
        internalProgram.append(operand as AnyObject)
    }
    
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constant(Double.pi), //Double.pi,
        "e" : Operation.Constant(M_E), //M_E,
        "√" : Operation.UnaryOperation(sqrt), //sqrt,
        "±" : Operation.UnaryOperation({ -$0 }),
        "cos" : Operation.UnaryOperation(cos), //cos
//        "×" : Operation.BinaryOperation({(op1: Double, op2: Double) -> Double in
//            return op1 * op2
//            }
//        ),
        "×" : Operation.BinaryOperation({$0 * $1 }),
        "÷" : Operation.BinaryOperation({$0 / $1 }),
        "+" : Operation.BinaryOperation({$0 + $1 }),
        "-" : Operation.BinaryOperation({$0 - $1 }),

        "=" : Operation.Equals
    ]
    
    //enum no inheritance
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func performOperation(symbol: String) {
        internalProgram.append(symbol as AnyObject)

        if let operation = operations[symbol] {
            switch operation {
            //case .Constant(let associateConstantValue): accumulator = associateConstantValue
            case .Constant(let value): accumulator = value
            case .UnaryOperation(let function): accumulator = function(accumulator)
            case .BinaryOperation(let fuction):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: fuction, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
            //accumulator = constant
        }
        
//        switch symbol {
//        case "π": accumulator = Double.pi
//        case "√" : accumulator = sqrt(accumulator)
//        default: break;
//        }
    }
    
    private func executePendingBinaryOperation()
    {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    private struct  PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
        
    }
    
    typealias PropertyList = AnyObject
    
    var program: PropertyList {
        get {
            return internalProgram as CalculatorBrain.PropertyList
        }
        set {
            clear()
            if let arrayOfOps = newValue as? [AnyObject] {
                for op in arrayOfOps {
                    if let operand = op as? Double {
                        setOperand(operand: operand)
                    } else if let operation = op as? String {
                        performOperation(symbol: operation)
                    }
                }
            }
        }
    }
    
    func clear() {
        accumulator = 0.0
        pending = nil
        internalProgram.removeAll()
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
}
