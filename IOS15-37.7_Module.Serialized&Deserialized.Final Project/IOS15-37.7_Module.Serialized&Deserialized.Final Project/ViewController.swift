//
//  ViewController.swift
//  IOS15-37.7_Module.Serialized&Deserialized.Final Project
//
//  Created by DiTRy on 31.10.2022.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var imagesArray: [String] = []
    var titlesArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //  Делаем запрос, получаем массив с картинками и массив с заголовками. Используем их для наполнения массивов, использующихся в таблице и обновляем таблицу
        NewsRequest.getNewsData(type: ArticlesModel.self) { imagesArray,titlesArray in
            self.imagesArray = imagesArray
            self.titlesArray = titlesArray
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate {
    //  Тут описываем действия при взаимодействии с таблицей
}

extension ViewController: UITableViewDataSource {
    //  Тут описываем внешний вид таблицы
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell else { return UITableViewCell() }
        cell.cellLabel.text = titlesArray[indexPath.row]
        cell.cellImage.sd_setImage(with: URL(string: imagesArray[indexPath.row]),
                                         placeholderImage: nil,
                                         options: [.continueInBackground, .progressiveLoad],
                                         completed: nil)
        return cell
    }
}
