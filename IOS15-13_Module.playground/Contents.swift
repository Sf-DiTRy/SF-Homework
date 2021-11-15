import UIKit
//                                      Модуль 13.6 Практическое задание
// Кортеж
print("     Задание 1. Кортежи")
let firstPerson = (age: 34, name: "Эрнест", middleName: "Витаминович")
let secondPerson = (age: 45, name: "Сигизмунд", middleName: "Аристархович")
print("\n     Достаем значения по индексу")
firstPerson.1
firstPerson.2
firstPerson.0
print("Первый персонаж - \(firstPerson.name) \(firstPerson.middleName), которому \(firstPerson.age) года")
print("\n     Достаем значения по параметру")
secondPerson.name
secondPerson.middleName
secondPerson.age
print("Второй персонаж - \(secondPerson.1) \(secondPerson.2), которому \(secondPerson.0) лет")
// Массивы
print("\n     Задание 2. Массивы")
print("\n     Есть массив «дни в месяцах».")
let monthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
print(monthDays)
print("\n     Выведено количество дней в каждом месяце.")
monthDays.forEach({print($0)})
print("\n     Есть массив с названиями месяцев.")
let monthNames = ["Январь","Февраль","Март","Апрель","Май","Июнь","Июль","Август","Сентябрь","Октябрь","Ноябрь","Декабрь"]
print(monthNames)
print("\n     Выведено количество дней в каждом месяце (название месяца + количество дней).")
for (index, value) in monthDays.enumerated() {
    print("\(monthNames[index]) \(value)")
}
print("\n     Есть кортеж с параметрами (имя месяца, количество дней).")
var tupleMonths = [("Январь", 31),("Февраль", 28), ("Март", 31), ("Апрель", 30), ("Май", 31), ("Июнь", 30), ("Июль", 31), ("Август", 31), ("Сентябрь", 30), ("Октябрь", 31), ("Ноябрь", 30), ("Декабрь", 31)]
print(tupleMonths)
print("\n     Выведено количество дней в каждом месяце используя массив кортежей (название месяца + количество дней).")
tupleMonths.forEach({print($0.0, $0.1)})
print("\n     Выведены имя месяца, количество дней в обратном порядке без изменения исходного массива.")
print(tupleMonths.sorted{s1,s2 in s1 > s2; return true}.forEach({print($0.0, $0.1)}))
print(tupleMonths)
// Словари
print("\n     Задание 3. Словари")
print("\n     Создан словарь, как журнал студентов, где имя и фамилия студента — это ключ, а оценка за экзамен — значение.")
var students: [String: Int] = ["Поджог Сараев": 1, "Рекорд Надоев": 4, "Залог Успехов": 5, "Налог Сдоходов": 3, "Отлов Приматов": 1]
print(students)
print("\n     Повысили оценку студенту.")
students["Отлов Приматов"] = 2
students.updateValue(2, forKey: "Отлов Приматов")
print(students)
print("\n     Если оценка положительная (4 или 5) или удовлетворительная (3), выведено сообщение с поздравлением, отрицательная (1, 2) — студента отправили на пересдачу.")
for (student, match) in students {
    if match < 3 {
        print("\(student), вы не прошли и вам необходимо отправиться на пересдачу")
    }
    else {
        print("\(student), поздравляем, вы прошли!")
    }
}
print("\n     Добавлено ещё несколько студентов.")
students["Иван Петров"] = 5
students["Василий Сидоров"] = 4
print(students)
print("\n     Один студент удалён (любым способом).")
students.removeValue(forKey: "Поджог Сараев")
print(students)
print("\n     Посчитан средний балл группы по итогам экзамена.")
var result = 0
for (_, match) in students {
    result += match
}
var averageScore: Double = Double(result)/Double(students.count)
print("Средний балл всей группы по итогам экзамена - \(averageScore)")
