//
//  NewsRequest.swift
//  IOS15-37.7_Module.Serialized&Deserialized.Final Project
//
//  Created by DiTRy on 29.10.2022.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class NewsRequest {

    static func getNewsData<T: Mappable>(type: T.Type, success: @escaping(_ imagesArray: [String], _ titlesArray: [String]) -> Void) where T: URLtoString {
        //  Делаем запрос через Alamofire. Ответ будет состоять из конструкции типа ArticlesModel или ошибки
        AF.request(type.urlAPI()).responseObject { (response: DataResponse<ArticlesModel, AFError>) in
            //  Перебираем варианты
            switch response.result {
            //  В случае успеха создаем два массива (для картинок и заголовков) и добавляем в них значения из ответа
            case .success(let articles):
                var articlesImages: [String] = []
                var articlesTitles: [String] = []
                for article in articles.articles! {
                    articlesImages.append(article.urlToImage ?? "")
                    articlesTitles.append(article.title ?? "")
                }
                DispatchQueue.main.async {
                    //  Выдаем результаты для дальнейшего использования
                    success(articlesImages, articlesTitles)
                }
            //  В случае ошибки просто выводим ее в консоль
            case .failure(let error):
                print(error)
            }
        }
    }
}
