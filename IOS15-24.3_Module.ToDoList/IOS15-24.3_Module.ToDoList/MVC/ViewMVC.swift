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
    
    var toDoCellEditButton = UIButton()
    var toDoCellDeleteButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setCellsSubviews()  //  Выставляем сабвью
        setTitle()
        setupToDoCellEditButton()   //  Устанавливаем кнопку toDoCellEditButton
        setupToDoCellDeleteButton() //  Устанавливаем кнопку toDoCellDeleteButton
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setCellsSubviews() {   //  Выводим кнопочки на ячейку
        self.addSubview(toDoCellEditButton)
        self.addSubview(toDoCellDeleteButton)
    }
    
    func setTitle() {
        NSLayoutConstraint.activate([self.contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor)])
    }
    
    func setupToDoCellEditButton() {
        toDoCellEditButton.contentMode = .scaleAspectFill
        toDoCellEditButton.setImage(UIImage(systemName: "square.and.pencil"), for: UIControl.State.normal)
        toDoCellEditButton.translatesAutoresizingMaskIntoConstraints = false
        toDoCellEditButton.clipsToBounds = true
        
        toDoCellEditButton.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([toDoCellEditButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     toDoCellEditButton.trailingAnchor.constraint(equalTo: self.toDoCellDeleteButton.leadingAnchor, constant: -10),
                                     toDoCellEditButton.widthAnchor.constraint(equalToConstant: 24),
                                     toDoCellEditButton.heightAnchor.constraint(equalToConstant: 24)])
        self.addSubview(toDoCellEditButton)

    }
    
    func setupToDoCellDeleteButton() {
        toDoCellDeleteButton.contentMode = .scaleAspectFill
        toDoCellDeleteButton.setImage(UIImage(systemName: "trash"), for: UIControl.State.normal)
        toDoCellDeleteButton.translatesAutoresizingMaskIntoConstraints = false
        toDoCellDeleteButton.clipsToBounds = true
        toDoCellDeleteButton.isEnabled = true
        toDoCellDeleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        
        self.toDoCellDeleteButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.toDoCellDeleteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50).isActive = true
        self.toDoCellDeleteButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        self.toDoCellDeleteButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.addSubview(toDoCellDeleteButton)

    }
    
    @objc func editButtonPressed() {    //  Кнопка Редактировать
        print("editButtonPressed")
        delegate?.editToDoCell(cell: self)
    }
    
    @objc func deleteButtonPressed() {    //  Кнопка Удалить
        print("deleteButtonPressed")
        delegate?.deleteToDoCell(cell: self)
    }
    
}
