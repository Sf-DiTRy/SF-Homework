//
//  AllTransactionsVC.swift
//  IOS15-Hackaton.BanksApp
//
//  Created by DiTRy on 22.03.2022.
//

import UIKit
import RealmSwift

class AllTransactionsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var timeAndDate = [Date]()
    var operation = [String]()
    var sum = [Float]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        dataToArray()
    }
    
    func dataToArray() {
        let realm = try! Realm()
        let transactions = realm.objects(Transaction.self)
        
        var byTimeAndDate = transactions.sorted(byKeyPath: "timeAndDate", ascending: false)
        for transaction in byTimeAndDate {
            timeAndDate.append(transaction.timeAndDate)
            operation.append(transaction.operation)
            sum.append(transaction.sum)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        let transactions = realm.objects(Person.self).first?.transactions
        return transactions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionsCell", for: indexPath) as? TransactionsCell else { return UITableViewCell() }
        cell.date.text = "\(timeAndDate[indexPath.row])"
        cell.operation.text = operation[indexPath.row]
        cell.summ.text = "\(sum[indexPath.row])"
        return cell
    }

}
