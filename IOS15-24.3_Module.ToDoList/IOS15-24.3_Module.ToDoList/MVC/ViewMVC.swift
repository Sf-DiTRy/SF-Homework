//
//  ViewMVC.swift
//  IOS15-24.3_Module.ToDoList
//
//  Created by DiTRy on 31.01.2022.
//

import Foundation
import UIKit

protocol ToDoCellCellDelegate { //  Создаем протокол делегата, которому будет поручено редактировать и удалять задачи
    func editToDoCell(cell: ToDoCell)   //  Он должен уметь редактировать задачу
    func deleteToDoCell(cell: ToDoCell) //  Он должен уметь удалять задачу
}

class ToDoCell: UITableViewCell {   //  Создаем ячейку с нужными элементами
    
    var delegate: ToDoCellCellDelegate? //  Создаем делегата, который соответствует протоколу. Действовать будет ViewControllerMVC при нажатии соответствующих кнопок ячейки.
    
    var toDoCellEditButton: UIButton = {    //  Добавляем кнопку изменения текста задачи
        let button = UIButton()
        button.contentMode = .scaleAspectFill
        button.setImage(UIImage(systemName: "square.and.pencil"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        return button
    }()
    var toDoCellDeleteButton: UIButton = {  //  Добавляем кнопку удаления задачи
        let button = UIButton()
        button.contentMode = .scaleAspectFill
        button.setImage(UIImage(systemName: "trash"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCellsSubviews()  //  Выставляем сабвью
        setCellsConstraints()   //  Выставляем констрейнты
      
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setCellsConstraints() {    //  Устанавливаем констрейнты для кнопок toDoCellDeleteButton и toDoCellEditButton
        self.toDoCellDeleteButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.toDoCellDeleteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50).isActive = true
        self.toDoCellDeleteButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        self.toDoCellDeleteButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        NSLayoutConstraint.activate([toDoCellEditButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     toDoCellEditButton.trailingAnchor.constraint(equalTo: self.toDoCellDeleteButton.leadingAnchor, constant: -10),
                                     toDoCellEditButton.widthAnchor.constraint(equalToConstant: 24),
                                     toDoCellEditButton.heightAnchor.constraint(equalToConstant: 24)])
    }
    
    func setCellsSubviews() {   //  Выводим кнопочки на ячейку
        self.addSubview(toDoCellEditButton)
        self.addSubview(toDoCellDeleteButton)
    }
    
    @objc func editButtonPressed() {    //  Кнопка Редактировать
        print("editButtonPressed")
//        delegate?.editToDoCell(cell: self)
    }
    
    @objc func deleteButtonPressed() {    //  Кнопка Удалить
        print("deleteButtonPressed")
        
        //  Пробую вывести Алерт при нажатии этой кнопки. Просто так, тест
        let alert = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        let leftButton = UIAlertAction(title: "Left", style: .default, handler: nil)
        alert.addAction(leftButton)
        alert.present(alert, animated: true, completion: nil)
//        delegate?.deleteToDoCell(cell: self)
    }
    
}
