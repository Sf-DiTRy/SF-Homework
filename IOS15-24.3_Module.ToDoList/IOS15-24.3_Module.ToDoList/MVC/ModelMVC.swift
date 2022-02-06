//
//  ModelMVC.swift
//  IOS15-24.3_Module.ToDoList
//
//  Created by DiTRy on 31.01.2022.
//

import Foundation
import UIKit

class Task {    //  Описываем задачу, которую будет передавать модель
    
    var taskText: String    //  У задачи есть текстовое описание
    var taskCheck: Bool     // У задачи есть пометка о выполнении в качестве чека
    
    init(taskText: String, taskCheck: Bool) {   //  Инициализируем свойства класса
        self.taskText = taskText
        self.taskCheck = taskCheck
    }
}

class Model {   //  Описываем модель, которая обрабатывает данные
    
    var toDoTasks: [Task] = [   //  Массив, содержащий задачи и пометку о выполнении в качестве чека
        Task(taskText: "First Task", taskCheck: true),
        Task(taskText: "Second Task", taskCheck: false),
        Task(taskText: "Third Task", taskCheck: false)
    ]
    
    var sortedByIncrease: Bool = true   //  Переменная описывающая тип текущей сортировки массива задач
    
    func addTask(taskText: String, taskCheck: Bool = false) {   //  Модель должна уметь добавлять новые элементы в массив задач без пометки о выполнении
        toDoTasks.append(Task(taskText: taskText, taskCheck: taskCheck))
    }

    func removeTask(at index: Int) {    //  Модель должна убирать из массива задачи по индексу. Индекс получим от ячейки
        toDoTasks.remove(at: index)
    }

    func moveTask(fromIndex: Int, toIndex: Int) {   //  Функция перемещения задачи на другую строку. Начальный и конечный индекс даст метод UITableView
        let from = toDoTasks[fromIndex] //  Вытягиваем задачу в отдельный массив from
        toDoTasks.remove(at: fromIndex) //  Удаляем задачу из массива задач
        toDoTasks.insert(from, at: toIndex) //  Вставляем задачу из from в нужное место массива задач
    }

    func updateTask(at index: Int, with string: String) {   //  Функция редактирования текста задачи. Индекс получим от ячейки, текст от UIAlertController
        toDoTasks[index].taskText = string
    }

    func changeState(at index: Int) -> Bool {    //  Функция изменения отметки о выполнении в массиве задач.
        toDoTasks[index].taskCheck = !toDoTasks[index].taskCheck // Принимает статус чека, меняет на противоположный
    return toDoTasks[index].taskCheck    //  и возвращает его
    }
    
    func sortByTaskText() { //  Реализация сортировки массива задач с помощью тернарной записи оператора if и обращению к элементам по их сокращенной форме записи
        toDoTasks.sort {
            sortedByIncrease ? $0.taskText < $1.taskText : $0.taskText > $1.taskText
        }
    }
    
}
