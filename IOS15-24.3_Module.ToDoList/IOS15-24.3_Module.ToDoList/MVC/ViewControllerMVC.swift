//
//  ViewControllerMVC.swift
//  IOS15-24.3_Module.ToDoList
//
//  Created by DiTRy on 31.01.2022.
//

import UIKit

class ViewControllerMVC: UITableViewController {

    let model = Model()
    var alert = UIAlertController()
        
    //  Cоздаем три кнопки для UIBarButtonItem
    let addTaskButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addTaskButtonPressed))
    let editTaskButton = UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .plain, target: self, action: #selector(editTaskButtonPressed))
    let sortingTaskButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up"), style: .plain, target: self, action: #selector(sortingTaskButtonPressed))
    
    let cell = ToDoCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white  // Устанавливаем цвет фона UITableViewController
        
        navigationController?.navigationBar.backgroundColor = .white  // Устанавливаем цвет фона UINavigationController'a
        navigationController?.navigationBar.prefersLargeTitles = true  //  Параметр, предписывающий UINavigationController'у выводить title в большом формате

        navigationItem.title = "Tasks" //  Подписываем title для UINavigationItem
        navigationItem.rightBarButtonItems = [addTaskButton, editTaskButton, sortingTaskButton] //  Добавляем кнопки в UIBarButtonItem
        addTaskButton.action = #selector(addTaskButtonPressed)

        self.tableView.register(ToDoCell.self, forCellReuseIdentifier: "cell")   //  Регистрируем ячейку с именем "cell"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.toDoTasks.count    //  Число строк приравниваем к количеству элементов в массиве задач
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {   //  Указываем чем будем наполнять ячейки TableView

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ToDoCell else {return UITableViewCell()}
        let currentItem = model.toDoTasks[indexPath.row]
        cell.textLabel?.text = currentItem.taskText
        cell.accessoryType = currentItem.taskCheck ? .checkmark : .none
        return cell

    }
    
    
    
    @objc func addTaskButtonPressed() {
        print("addTaskButtonPressed")
        alert = UIAlertController(title: "Create new task", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Put your task here"
            textField.addTarget(self, action: #selector(self.alertTextFieldDidChange(_:)), for: .editingChanged)
        }
        
        let createAlertAction = UIAlertAction(title: "Create", style: .default) { (createAlert) in
            guard let itemTitle = self.alert.textFields?[0].text else { return }
            self.model.addTask(taskText: itemTitle)
            self.model.sortByTaskText()
            self.tableView.reloadData()
        }
        
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(cancelAlertAction)
        alert.addAction(createAlertAction)
        present(alert, animated: true, completion: nil)
        createAlertAction.isEnabled = false

    }
    
    @objc func alertTextFieldDidChange(_ sender: UITextField) {

            guard let senderText = sender.text, alert.actions.indices.contains(1) else {
                return
            }

            let action = alert.actions[1]
            action.isEnabled = senderText.count > 0
        }

    @objc func editTaskButtonPressed() {
        print("editTaskButtonPressed")
    }
    
    @objc func sortingTaskButtonPressed() {
        print("sortingTaskButtonPressed")
    }
    
}

