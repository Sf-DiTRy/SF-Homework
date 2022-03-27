//
//  TransactionsCell.swift
//  IOS15-Hackaton.BanksApp
//
//  Created by DiTRy on 26.03.2022.
//

import UIKit

class TransactionsCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var operation: UILabel!
    @IBOutlet weak var summ: UILabel!
    @IBOutlet weak var rub: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
