import UIKit

// 1. Создано перечисление, которое соответствует протоколу Error. Для него создано любые 3 кейса —  ошибки. Есть переменная, которая хранит в себе ошибку (400 или 404 или 500). Есть обработка ошибок перечисления при помощи do-catch. Для каждой ошибки выведено сообщение в консоль.

enum Errors: Error {
    case isError400 // ошибка 400
    case isError404 // ошибка 404
    case isError500 // ошибка 500
}

var isError400 = true
var isError404 = false
var isError500 = false

do {
    if isError400 {
        throw Errors.isError400
    }
    if isError404 {
        throw Errors.isError404
    }
    if isError500 {
        throw Errors.isError500
    }
} catch Errors.isError400 {
        print("Ошибка 400 Bad Request (Через If)")
} catch Errors.isError404 {
        print("Ошибка 404 Not Found (Через If)")
} catch Errors.isError500 {
        print("Ошибка 500 Internal Server Error (Через If)")
}

// 2. Есть проверка переменных в генерирующей функцию, есть её обработка.

func errorCatcher () throws {
    if isError400 { throw Errors.isError400}
    if isError404 { throw Errors.isError404}
    if isError500 { throw Errors.isError500}
}

do {
    try errorCatcher()
} catch Errors.isError400 {
        print("Ошибка 400 Bad Request (Через функцию)")
} catch Errors.isError404 {
        print("Ошибка 404 Not Found (Через функцию)")
} catch Errors.isError500 {
        print("Ошибка 500 Internal Server Error (Через функцию)")
}

// 3. Есть функция, принимающая на вход два разных типа, которая проверяет типы входных значений. Выводит “Yes”, если они одинаковые, в противном случае — “No”.

let typeA = 1
let typeB = 2
print("\nВходное значение А - \(typeA), входное значение В - \(typeB)")
func sravnenieTipov <T, E> (_ a: T, _ b: E) {
    if type(of: a) == type(of: b) {
        print("Yes (Сравнение типов)")
    } else {
        print("No (Сравнение типов)")
    }
}
sravnenieTipov(typeA, typeB)

// 4. Реализовано то же самое, что и в пункте 3, но если тип входных значений различается, выбрасывается исключение. Если тип одинаковый — исключение тоже выбрасывается.

enum Exeption: Error {
    case isTrue, isFalse
}

func sravnenieTipov2 <T, E> (_ a: T, _ b: E) throws {
    if type(of: a) == type(of: b) {
        throw Exeption.isTrue
    } else {
        throw Exeption.isFalse
    }
}
do {
    try sravnenieTipov2(typeA, typeB)
} catch Exeption.isTrue {
    print("Верно (Сравнение типов через исключения)")
} catch Exeption.isFalse {
    print("Неверно (Сравнение типов через исключения)")
}

// 5. Есть функция, которая принимает на вход два любых значения и сравнивает их при помощи оператора равенства (==).

func sravnenie <T: Equatable> (_ a: T, _ b: T) -> Bool {
    return a == b
}
print("Результат сравнения значений - \(sravnenie(typeA, typeB))")
