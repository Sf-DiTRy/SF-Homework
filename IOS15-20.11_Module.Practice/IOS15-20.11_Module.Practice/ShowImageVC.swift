//
//  ShowImageVC.swift
//  IOS15-20.11_Module.Practice
//
//  Created by DiTRy on 07.01.2022.
//

import UIKit

class ShowImageVC: UIViewController {
    
    @IBOutlet weak var currentImage: UIImageView!
    
    var imageName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentImage.image = UIImage(named: imageName)
    }
    
    func setImageName(name: String){
        imageName = name
    }

}
