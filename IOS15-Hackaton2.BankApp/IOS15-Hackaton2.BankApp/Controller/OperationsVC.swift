//
//  OperationsVC.swift
//  IOS15-Hackaton.BanksApp
//
//  Created by DiTRy on 22.03.2022.
//

import UIKit
import RealmSwift

class OperationsVC: UIViewController {

    @IBOutlet weak var labelFrom: UILabel!
    var from = ""
    
    @IBOutlet weak var labelTo: UILabel!
    var to = ""
    
    @IBOutlet weak var textField: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTo.text = to
        labelFrom.text = from

    }
    @IBAction func confirmButtonAction(_ sender: Any) {
        guard let value = Float(textField.text ?? "0") else { return }
        operation(from: from, to: to, value: value)
        navigationController?.popViewController(animated: true)
    }
    
    func operation(from: String, to: String, value: Float) {
        let realm = try! Realm()
        let person = realm.objects(Person.self)
        guard let currentPerson = person.first else { return }
        
        try! realm.write {
            if from == "Депозит" && to == "Наличные" {
                if currentPerson.deposit >= value {
                    currentPerson.deposit -= value
                    currentPerson.cash += value
                    addTransaction(from: from, to: to, value: value)
                } else {
                    showAlert()
                }
            } else if from == "Наличные" && to == "Депозит" {
                if currentPerson.cash >= value {
                    person.first?.cash -= value
                    person.first?.deposit += value
                    addTransaction(from: from, to: to, value: value)
                } else {
                    showAlert()
                }
            } else if from == "Депозит" && to == "Мобильный телефон" {
                if currentPerson.deposit >= value {
                    person.first?.deposit -= value
                    person.first?.mobile += value
                    addTransaction(from: from, to: to, value: value)
                } else {
                    showAlert()
                }
            }
        }
    }
    
    func addTransaction(from: String, to: String, value: Float) {
        let realm = try! Realm()
        let person = realm.objects(Person.self)
        let transaction = Transaction()
        
        if from == "Депозит" && to == "Наличные" {
            transaction.timeAndDate = Date()
            transaction.operation = "Списание"
            transaction.target = to
            transaction.sum = value
            transaction.type = "руб."
            person.first?.transactions.append(transaction)
        } else if from == "Наличные" && to == "Депозит" {
            transaction.timeAndDate = Date()
            transaction.operation = "Зачисление"
            transaction.target = to
            transaction.sum = value
            transaction.type = "руб."
            person.first?.transactions.append(transaction)
        } else if from == "Депозит" && to == "Мобильный телефон" {
            transaction.timeAndDate = Date()
            transaction.operation = "Пополнение мобильного"
            transaction.target = to
            transaction.sum = value
            transaction.type = "руб."
            person.first?.transactions.append(transaction)
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Превышена сумма", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true)  //  Показываем алерт на экране
    }
}

