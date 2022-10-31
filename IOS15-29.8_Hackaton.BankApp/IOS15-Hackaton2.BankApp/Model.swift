//
//  Model.swift
//  IOS15-Hackaton.BanksApp
//
//  Created by DiTRy on 23.03.2022.
//

import RealmSwift

class Person: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var deposit: Float = 0.0
    @objc dynamic var cash: Float = 0.0
    @objc dynamic var mobile: Float = 0.0
    let transactions = List<Transaction>()
}

class Transaction: Object {
    @objc dynamic var timeAndDate = Date()
    @objc dynamic var operation: String = ""
    @objc dynamic var target: String = ""
    @objc dynamic var sum: Float = 0.0
    @objc dynamic var type: String = ""
}
