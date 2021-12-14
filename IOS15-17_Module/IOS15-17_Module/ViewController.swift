//
//  ViewController.swift
//  IOS15-17_Module
//
//  Created by DiTRy on 05.12.2021.
//

import UIKit

class ViewController: UIViewController {
    var inputNumber = ""
    var mathAction: String = ""
    var firstAction = true
    var firstNumber: Double? = nil
    var secondNumber: Double? = nil
    var answerNumber: Double? = nil
    var point = false
    var minus = false
    var isInteger = true
    var enteringText = true
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func clearResultLanel(_ sender: UIButton) {
        inputNumber = ""
        mathAction = ""
        firstAction = true
        firstNumber = 0
        secondNumber = nil
        answerNumber = 0
        resultLabel.text = "0"
        point = false
        minus = false
    }
    
    @IBAction func pointButton(_ sender: UIButton) {
        if point == false && inputNumber != "" {
            inputNumber += "."
            point = true
            resultLabel.text = inputNumber
        } else {
            inputNumber += "0."
            point = true
            resultLabel.text = inputNumber
        }
    }
    
    @IBAction func numPress(_ sender: UIButton) {
        let number = sender.currentTitle!
        if inputNumber != "0" {
            inputNumber += number
            resultLabel.text = inputNumber
        } else {
            inputNumber = ""
            inputNumber += number
            resultLabel.text = inputNumber
        }
    }
    
    @IBAction func revers(_ sender: UIButton) {
        if inputNumber != "" {
            if minus == false {
                inputNumber = "-" + inputNumber
                minus = true
                resultLabel.text = inputNumber
            } else {
                inputNumber.remove(at: inputNumber.startIndex)
                minus = false
                resultLabel.text = inputNumber
            }
        }
    }
    
    @IBAction func persentButton(_ sender: UIButton) {
        answerNumber = Double(inputNumber)! * 0.01
        resultLabel.text = String(answerNumber!)

//        isInteger = answerNumber! - answerNumber!.rounded() == 0
//        if isInteger {
//            resultLabel.text = String(Int(answerNumber!))
//        } else {
//            resultLabel.text = String(answerNumber!)
//        }
        inputNumber = String(answerNumber!)
    }
    
    @IBAction func mathOperation(_ sender: UIButton) {
        mathAction = sender.currentTitle!
        firstNumber = Double(inputNumber)
        inputNumber = ""
    }
    
    @IBAction func getResult(_ sender: UIButton) {
        secondNumber = Double(inputNumber)
        switch mathAction {
        case "+":
            answerNumber = firstNumber! + secondNumber!
        case "-":
            answerNumber = firstNumber! - secondNumber!
        case "/":
            answerNumber = firstNumber! / secondNumber!
        case "x":
            answerNumber = firstNumber! * secondNumber!
        default: break
        }
        isInteger = answerNumber! - answerNumber!.rounded() == 0
        if isInteger {
            resultLabel.text = String(Int(answerNumber!))
        } else {
            resultLabel.text = String(answerNumber!)
        }
    }
}
