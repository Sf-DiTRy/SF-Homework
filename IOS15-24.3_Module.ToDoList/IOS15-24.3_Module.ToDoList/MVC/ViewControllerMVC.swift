//
//  ViewControllerMVC.swift
//  IOS15-24.3_Module.ToDoList
//
//  Created by DiTRy on 31.01.2022.
//

import UIKit

class ViewControllerMVC: UITableViewController {

    let model = Model()
    let cell = ToDoCell()
    var alert = UIAlertController()
    var addTaskButton = UIBarButtonItem()
    var editTaskButton = UIBarButtonItem()
    var sortingTaskButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white  // Устанавливаем цвет фона UITableViewController

        setNavigationBar()
        createBarButtonItems()
        
        self.tableView.register(ToDoCell.self, forCellReuseIdentifier: "cell")   //  Регистрируем ячейку с именем "cell"
    }
    
    // MARK: - NavigationItem
    
    func setNavigationBar() {   //  Устанавливаем свойства NavigationBar
        navigationController?.navigationBar.backgroundColor = .white  // Устанавливаем цвет фона UINavigationController'a
        navigationController?.navigationBar.prefersLargeTitles = true  //  Параметр, предписывающий UINavigationController'у выводить title в большом формате
        navigationItem.title = "Tasks" //  Подписываем title для UINavigationItem
    }
    
    func createBarButtonItems() {    //  Cоздаем три кнопки для UIBarButtonItem, ставим их в стек rightBar
        addTaskButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(pressedAddTaskButton))
        editTaskButton = UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .plain, target: self, action: #selector(pressedEditTaskButton))
        sortingTaskButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up"), style: .plain, target: self, action: #selector(pressedSortingTaskButton))
        navigationItem.rightBarButtonItems = [addTaskButton, editTaskButton, sortingTaskButton] //  Добавляем кнопки в UIBarButtonItem
    }

    @objc func pressedAddTaskButton() { //  Нажата кнопка AddTask
        alert = UIAlertController(title: "Создать новую задачу", message: nil, preferredStyle: .alert)   //  Прописываем свойства AlertController'у
        alert.addTextField { (textField: UITextField) in    //  Прописываем свойство TextField AlertController'а
            textField.placeholder = "Добавьте свою задачу сюда"    //  Добавляем текст placeholder'у
            textField.addTarget(self, action: #selector(self.alertTextFieldDidChange(_:)), for: .editingChanged)    //  Добавляем действие, которое необходимо выполнить при условии появления текста в TextField
        }
        
        let createAlertAction = UIAlertAction(title: "Добавить", style: .default) { (createAlert) in  //  Создаем алерту кнопку Добавить
            guard let taskText = self.alert.textFields?[0].text else { return }
            self.model.addTask(taskText: taskText)
            self.model.sortByTaskText()
            self.tableView.reloadData()
        }
        
        let cancelAlertAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)  //   Создаем алерту кнопку Отмена

        alert.addAction(cancelAlertAction)  //  Добавляем кнопку "Отмена" алерту
        alert.addAction(createAlertAction)  //  Добавляем кнопку "Добавить" алерту
        present(alert, animated: true, completion: nil) //  Выводим алерт с анимацией
        createAlertAction.isEnabled = false //  Делаем кнопку "Добавить" не активной

    }
    
    @objc func pressedEditTaskButton() { //  Нажата кнопка EditTask
        let editOn = UIImage(systemName: "pencil")
        let editOff = UIImage(systemName: "pencil.slash")
        tableView.setEditing(!tableView.isEditing, animated: true)  //  Включаем редактирование таблицы (метод setEditing)
        
        model.editButtonClicked = !model.editButtonClicked    //  Меняем положение "флажка"
        editTaskButton.image = model.editButtonClicked ? editOn : editOff  //  Иконка меняется в зависимости от "флажка"
    }
    
    @objc func pressedSortingTaskButton() { //  Нажата кнопка SortingTask
        let arrowUp = UIImage(systemName: "arrow.up")
        let arrowDown = UIImage(systemName: "arrow.down")
        model.sortedByIncrease = !model.sortedByIncrease    //  Меняем положение "флажка"
        sortingTaskButton.image = model.sortedByIncrease ? arrowUp : arrowDown  //  Иконка меняется в зависимости от "флажка"
        model.sortByTaskText()  //  Сортировка проводится в зависимости от "флажка"
        self.tableView.reloadData() //  Обновляем данные таблицы
    }
    
    @objc func alertTextFieldDidChange(_ sender: UITextField) { //  Изменилось текстовое поле UIAlertController'а
            guard let senderText = sender.text, alert.actions.indices.contains(1) else { return }   //  Утверждаем, что senderText это текст UITextField от алерта, а вот с индексами действий алерта не понятно (((
            let action = alert.actions[1]   //  Пусть action будет кнопкой Добавить (она в массиве под индексом 1)
            action.isEnabled = senderText.count > 0 //  Если в массиве литерала больше 0 символов, делаем кнопку добавить активной
        }

    
        // MARK: - UITableView

    override func numberOfSections(in tableView: UITableView) -> Int {  //  Число секций таблицы
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {  //  Число строк таблицы
        return model.toDoTasks.count    //  Число строк приравниваем к количеству элементов в массиве задач
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {   //  Указываем чем будем наполнять ячейки TableView

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ToDoCell else {return UITableViewCell()}
        let currentItem = model.toDoTasks[indexPath.row]
        cell.textLabel?.text = currentItem.taskText
        cell.accessoryType = currentItem.taskCheck ? .checkmark : .none
        return cell

    }
    
    
//  ДОПОЛНИТЕЛЬНЫЕ ФУНКЦИИ TABLeVIEW:
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {  //  Прописываем что надо удалить в режиме редактирования таблицы
        if editingStyle == UITableViewCell.EditingStyle.delete {
            model.toDoTasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }

    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {  //  Прописываем что надо двигать в режиме редактирования таблицы
        model.moveTask(fromIndex: fromIndexPath.row, toIndex: to.row)
        tableView.reloadData()
    }
    
}

extension ViewControllerMVC: ToDoCellCellDelegate {
    func editToDoCell(cell: ToDoCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
//        model.updateTask(at: <#T##Int#>, with: <#T##String#>)
//        self.editCellContent(at: indexPath)
    }
    
    func deleteToDoCell(cell: ToDoCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
        model.removeTask(at: indexPath.row)
        self.tableView.reloadData()
    }
}
