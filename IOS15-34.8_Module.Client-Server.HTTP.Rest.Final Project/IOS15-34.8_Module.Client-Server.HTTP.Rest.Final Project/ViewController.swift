//
//  ViewController.swift
//  IOS15-34.8_Module.Client-Server.HTTP.Rest.Final Project
//
//  Created by DiTRy on 26.05.2022.
//
//  Итоговое практическое задание по модулю 34:
/*  Требования:
 -  Все посты получены, используя GET-запрос, где число NN— это id поста: https://jsonplaceholder.typicode.com/comments?postId=NN
 -  Id поста можно изменить, введя нужный id на экране;
 -  Результаты запроса должны быть отображены на экране (в формате JSON). Например, вы можете использовать TextView;
 -  Если всё содержимое не влезает, должна быть возможность проскроллить.
 */

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var requestTextView: UITextView!
    
    let dispatchQueue = DispatchQueue(label: "DispatchQueue")
    let adress = URL(string: "https://jsonplaceholder.typicode.com")
    
    var idPost = String()
    var text = ""
    var alert = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestTextView.text = text
    }

    @IBAction func requestButton(_ sender: UIButton) {
            self.createAlert()
    }

    func createAlert() {
        alert = UIAlertController(title: "Введите Id поста", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Введите сюда желаемый Id поста"
        }

        //   Создаем алерту кнопку
        let confirmAlertButton = UIAlertAction(title: "Отправить", style: .cancel) { send in
            guard let alertText = self.alert.textFields?[0].text else { return }
            self.dispatchQueue.sync {
                self.idPost = alertText
                self.createRequest()
            }
            self.dispatchQueue.sync {
                sleep(1)
                self.requestTextView.text = self.text
                print("requestTextView.text = self.text COMPLETED")
            }
        }
        alert.addAction(confirmAlertButton)
        present(alert, animated: true, completion: nil) //  Выводим алерт с анимацией
    }
    
    func createRequest() {
        let category = "comments"
        guard var requestURL = URL(string: category, relativeTo: adress) else { return }
        requestURL.appendQueryItem(name: "postId", value: idPost)
        
        var request = URLRequest(url: requestURL)

        // Далее указываем http-метод. Мы будем ПОЛУЧАТЬ данные, поэтому указываем GET:
        request.httpMethod = "GET"

        // В качестве заголовка (header) нам обязательно нужно использовать «Content-Type», чтобы получить результат выполнения запроса в нужном нам формате, а именно в формате JSON.
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Создаем задачу, используя запрос. В замыкании указываем data, response, error - в дальнейшем мы будем их использовать.
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Делаем data неопциональной
            guard let data = data,
                  // Декодируем data в формат .utf8
                  let dataString = String(data: data, encoding: .utf8),
                  // Проверяем, успешно ли выполнился запрос, используя statusCode
                  (response as? HTTPURLResponse)?.statusCode == 200,
                  // Проверяем, нет ли ошибок

                  error == nil else { return }
            // Переменной text присваиваем значение результата
            self.text = dataString
            print("ВОТ ЧТО ПОПАЛО В ТЕКСТ - \(self.text)")
            }
        task.resume()
    }

}

extension URL { //  Этот метод может добавить QueryItem к существующему URL-адресу

    func appending(_ queryItem: String, value: String?) -> URL {

        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

        // Создаем массив существующих параметров запроса
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Создаем новый параметр запроса
        let queryItem = URLQueryItem(name: queryItem, value: value)

        // Добавляем новый параметр запроса к существующим в массив
        queryItems.append(queryItem)

        // Заменяем массив параметров запроса на обновленный
        urlComponents.queryItems = queryItems

        // Возвращаем url с новым параметром запроса
        return urlComponents.url!
    }
}

extension URL { //  В этом методе URL-адрес будет обновляться автоматически

    mutating func appendQueryItem(name: String, value: String?) {

        guard var urlComponents = URLComponents(string: absoluteString) else { return }

        // Создаем массив существующих параметров запроса
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Создаем новый параметр запроса
        let queryItem = URLQueryItem(name: name, value: value)

        // Добавляем новый параметр запроса к существующим в массив
        queryItems.append(queryItem)

        // Заменяем массив параметров запроса на обновленный
        urlComponents.queryItems = queryItems

        // Обновляем url на url с новым параметром запроса
        self = urlComponents.url!
    }
}

          // Еще один вариант получить URL с параметрами запроса
//        var components = URLComponents()
//        components.scheme = "https"
//        components.host = "jsonplaceholder.typicode.com"
//        let queryItem = [URLQueryItem(name: "postId", value: "1")]
//        components.queryItems = queryItem
//        print(components.url!.absoluteString)
