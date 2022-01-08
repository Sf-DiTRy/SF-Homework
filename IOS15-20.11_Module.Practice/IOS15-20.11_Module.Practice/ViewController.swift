//
//  ViewController.swift
//  IOS15-20.11_Module.Practice
//
//  Created by DiTRy on 07.01.2022.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionViewOne: UICollectionView!
    @IBOutlet weak var collectionViewTwo: UICollectionView!
    
    let arrayTemperature = ["temp.green", "temp.blackGreen", "temp.lightYellow", "temp.darkYellow", "temp.orange", "temp.red", ]
    let arraySmile = ["nice", "favorite", "routine", "notPleasant", "bad", "hate", "nice", "favorite", "routine"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewOne.delegate = self
        collectionViewOne.dataSource = self
        
        collectionViewTwo.delegate = self
        collectionViewTwo.dataSource = self
    }
    
//  Обрабатываем событие нажатия на ячейку UICollectionView
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//      Получаем доступ к ShowImageVC через безопасную ссылку, проверяя идентификатор и соответствие типа
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ShowImageVC") as? ShowImageVC else {return}
        var currentSelectedImage: String!
        
        if collectionView == collectionViewOne {
            currentSelectedImage = arrayTemperature[indexPath.row]
        }
        
        if collectionView == collectionViewTwo {
            currentSelectedImage = arraySmile[indexPath.row]
        }
        
        vc.setImageName(name: currentSelectedImage)
        present(vc, animated: true, completion: nil)
    }
    
//  Указываем количество Item в зависимости от необходимой collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewOne {
            return arrayTemperature.count
        }
        
        if collectionView == collectionViewTwo {
            return arraySmile.count
        }
        return 0
    }
    
//  Наполняем ячейки данными в зависимости от необходимой collectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewOne {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellOne", for: indexPath) as? Cell {
                let imageName = arrayTemperature[indexPath.row]
                cell.setTemperatureImage(tempName: imageName)
                return cell
            }
        }
        if collectionView == collectionViewTwo {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellTwo", for: indexPath) as? Cell {
                let imageName = arraySmile[indexPath.row]
                cell.setSmileImage(smileName: imageName)
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

