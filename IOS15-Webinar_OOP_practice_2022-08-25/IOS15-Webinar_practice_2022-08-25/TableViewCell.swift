//
//  TableViewCell.swift
//  IOS15-Webinar_practice_2022-08-25
//
//  Created by DiTRy on 31.08.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var cellsImage: UIImageView!
    @IBOutlet weak var cellsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
