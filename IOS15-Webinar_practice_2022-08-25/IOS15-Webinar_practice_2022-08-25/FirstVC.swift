//
//  FirstVC.swift
//  IOS15-Webinar_practice_2022-08-25
//
//  Created by DiTRy on 31.08.2022.
//

// ЗАДАЧА Простое приложение, 1-2 экрана UIKit с кнопкой. Реализовано полностью, вместо кнопки - ячейки таблицы

import UIKit

// Принцип ООП Наследование — создание нового класса на основе существующего класса. Класс FirstVC наследуется от UIViewController
class FirstVC: UIViewController {   // Принцип ООП Наследование — создание нового класса на основе существующего класса
    // Принцип ООП Инкапсуляция - скрытие внутреннего состояния и функций объекта и предоставление доступа только через открытый набор функций. Применение уровней доступа и демонстрирует принцип. По-умолчанию он internal
    private let iconsArray = CellContent().iconsArray   // Задача 4* Использование уровней доступа. Так как переменная iconsArray не планируется к применению за пределами класса FirstVC, можем сделать ее private
    @IBOutlet weak var tableView: UITableView! // Принцип ООП Наследование. Класс UITableView наследуется от UIScrollView, NSCoding и UIDataSourceTranslating
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
}

extension FirstVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        iconsArray.count    //  Количество ячеек по количеству элементов в массиве
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as? TableViewCell else { return TableViewCell() }
        cell.cellsLabel.text = iconsArray[indexPath.row]
        cell.cellsImage.image = UIImage(systemName: iconsArray[indexPath.row])
        return cell
    }
    
    // ЗАДАЧА Взаимодействие с объектами. Функция реагирования на нажатие одной из ячеек. Передает данные из первого вью контроллера во второй, меняя при этом картинку и лейбл последнего
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let secondVC = storyboard.instantiateViewController(withIdentifier: "SecondVC") as? SecondVC else { return }
        let currentIcon = iconsArray[indexPath.row]
        secondVC.iconName = currentIcon
        show(secondVC, sender: nil)
    }
    
    // Если бы я использовал кнопку, то принцип ООП Полиморфизм показывал на переопределении функции prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "secondVC" else { return }
        guard let secondVC = segue.destination as? SecondVC else { return }
        secondVC.iconName = "Новая иконка"
    }
}


