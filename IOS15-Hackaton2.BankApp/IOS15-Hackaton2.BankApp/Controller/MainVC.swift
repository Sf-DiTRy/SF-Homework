//
//  ViewController.swift
//  IOS15-Hackaton.BanksApp
//
//  Created by DiTRy on 22.03.2022.
//

import UIKit
import RealmSwift

class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelDeposit: UILabel!
    @IBOutlet weak var labelCash: UILabel!
    @IBOutlet weak var labelMobile: UILabel!
    let deposit = "Депозит"
    let cash = "Наличные"
    let mobile = "Мобильный телефон"
    var timeAndDate = [Date]()
    var operation = [String]()
    var sum = [Float]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        print(realm.configuration.fileURL!)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        dataToArray()
        presentInfo()
    }

    @IBAction func btnDepositToCashPressed(_ sender: UIButton) {
        openOperationsVC(from: deposit, to: cash)
    }
    
    @IBAction func btnCashToDepositPressed(_ sender: UIButton) {
        openOperationsVC(from: cash, to: deposit)
    }
    
    @IBAction func btnDepositToMobilePressed(_ sender: UIButton) {
        openOperationsVC(from: deposit, to: mobile)
    }
    
    func presentInfo() {
        let realm = try! Realm()
        let person = realm.objects(Person.self)
        
        let deposit = person.first?.deposit
        let cash = person.first?.cash
        let mobile = person.first?.mobile
        labelDeposit.text = String(describing: deposit!)
        labelCash.text = String(describing: cash!)
        labelMobile.text = String(describing: mobile!)
    }
    
    func openOperationsVC(from: String, to: String) {
        guard let operationsVC = storyboard?.instantiateViewController(withIdentifier: "OperationsVC") as? OperationsVC else {return}
        operationsVC.from = from
        operationsVC.to = to
        navigationController?.pushViewController(operationsVC, animated: true)
    }
}

extension MainVC: UITableViewDelegate {
    
}

extension MainVC: UITableViewDataSource {
    
    func dataToArray() {
        timeAndDate = []
        operation = []
        sum = []
        let realm = try! Realm()
        let transactions = realm.objects(Transaction.self)
        
        var byTimeAndDate = transactions.sorted(byKeyPath: "timeAndDate", ascending: false)
        for transaction in byTimeAndDate {
            timeAndDate.append(transaction.timeAndDate)
//            print("Длина массива timeAndDate - \(timeAndDate.count)")
            operation.append(transaction.operation)
//            print("Длина массива operation - \(operation.count)")
            sum.append(transaction.sum)
//            print("Длина массива sum - \(sum.count)")
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeAndDate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShortTransactionsCell", for: indexPath) as? TransactionsCell else { return UITableViewCell() }
        print("Value of indexPath is - \(indexPath.row)")
        cell.date.text = "\(timeAndDate[indexPath.row])"
        cell.operation.text = operation[indexPath.row]
        cell.summ.text = "\(sum[indexPath.row])"
        return cell
    }
}
