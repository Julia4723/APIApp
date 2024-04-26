//
//  NetworkManager.swift
//  APIApp
//
//  Created by user on 12.04.2024.
//

//Создаем синглтон для работы с сетью

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    //Метод для загрузки изображений
    // completion - убегающее замыкание
    func fetchImage(from url: URL, completion: @escaping (Result<Data,NetworkError>) -> Void) {
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    
  //Метод, который парсит любой JSON
    func fetch<T: Decodable>(_ type: T.Type, from url:URL, completion: @escaping (Result<T,NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let dataModel = try decoder.decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
               
            } catch {
                print("Ошибка декодирования \(error)")
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
 
    
    
    func postRequest(with parameters: [String: Any], to url: URL, completion: @escaping(Result<Any, NetworkError>) -> Void) {
        
        // Создаем из словаря JSON
        // Класс JSONSerialization() создает JSON на основе словаря
        let serializedData = try? JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url) //Создаем запрос на сервер по определенному url адресу
        request.httpMethod = "POST" //Название протокола для метода httpMethod
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = serializedData //Вкладываем данные
        
        
        //Создаем сессию
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, let response else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print(json)
            } catch {
                print(error)
            }
        }.resume()
        
    }
    
    
    
    
    
    func postRequest(with parameters: Game, to url: URL, completion: @escaping(Result<Any, NetworkError>) -> Void) {
        
        guard let encodedJSON = try? JSONEncoder().encode(parameters) else {
            completion(.failure(.noData))
            return
        }
        
        var request = URLRequest(url: url) //Создаем запрос на сервер по определенному url адресу
        request.httpMethod = "POST" //Название протокола для метода httpMethod
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = encodedJSON //Вкладываем данные
        
        URLSession.shared.dataTask(with: request) {
            data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error descr")
                return
                           
            }
            do {
                let game = try JSONDecoder().decode(Game.self, from: data)
                completion(.success(game))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
        
    }
    
    
    
    
    
    
    func fetchQuotes(from url: URL, completion: @escaping(Result<[Game],AFError>) -> Void){
        AF.request(url)
            .validate()
            .responseJSON {dataResponse in
                switch dataResponse.result {
                case .success(let jsonValue):
                    let games = Game.getQuotes(from: jsonValue)
                    completion(.success(games))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
    
    private init() {}
    
}
