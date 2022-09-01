//
//  SecondVC.swift
//  IOS15-Webinar_practice_2022-08-25
//
//  Created by DiTRy on 31.08.2022.
//

import UIKit

class SecondVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    var iconName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(systemName: iconName)
        label.text = iconName
    }
    


}
