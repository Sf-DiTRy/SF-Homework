//
//  Cell.swift
//  IOS15-20.11_Module.Practice
//
//  Created by DiTRy on 07.01.2022.
//

import UIKit

class Cell: UICollectionViewCell {
    
    @IBOutlet weak var temperatureImage: UIImageView!
    @IBOutlet weak var smileImage: UIImageView!
    
    func setTemperatureImage(tempName: String) {
        temperatureImage.image = UIImage(named: tempName)
    }
    
    func setSmileImage(smileName: String) {
        smileImage.image = UIImage(named: smileName)
    }
}
