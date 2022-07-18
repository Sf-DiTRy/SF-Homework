//
//  SecondViewController.swift
//  TestProject
//
//  Created by SF on 01.06.2021.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var friendsLabel: UILabel!
    @IBOutlet weak var isClosedPageSwitch: UISwitch!
    
    struct Profile {
        
        let fullName: String
        let city: String
        let friends: [User]
        let isClosedPage: Bool
    }
    
    var profile: Profile = Profile(fullName: "", city: "", friends: [], isClosedPage: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullNameLabel.text = profile.fullName
        cityLabel.text = profile.city
        friendsLabel.text = profile.friends.map { $0.firstName + " " + $0.lastName }.joined(separator:"\n")
        isClosedPageSwitch.isOn = !profile.isClosedPage
        isClosedPageSwitch.isEnabled = false
    }
}
