//
//  MainViewController.swift
//  APIApp
//
//  Created by user on 07.04.2024.
//

import UIKit


enum Link {
    case imageURL
    case geoURL
    case quotesURL
    case nextOneURL
    case nextTwoURL
    
    var url: URL {
        switch self {
        case .imageURL:
            return URL(string: "https://http.cat/images/414.jpg")!
        case .geoURL:
            return URL(string: "https://get.geojs.io/v1/ip/geo.json")!
        case .quotesURL:
            return URL(string: "https://api.gameofthronesquotes.xyz/v1/random")!
        case .nextOneURL:
            return URL(string: "https://swiftbook.ru//wp-content/uploads/api/api_website_description")!
        case .nextTwoURL:
            return URL(string: "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields")!
        }
    }
}

enum UserAction: CaseIterable {
    case showImage
    case fetchGeo
    case fetchQuotes
    case nextOne
    case nextTwo
    
    var title: String {
        switch self {
        case .showImage:
            return "Show Image"
        case .fetchGeo:
            return "Fetch Geo"
        case .fetchQuotes:
            return "Fetch Quotes"
        case .nextOne:
            return "About Next"
        case .nextTwo:
            return "About Next Two"
        }
    }
}

final class MainViewController: UICollectionViewController {
    private let userActions = UserAction.allCases //Массив с кейсами перечислений
    
    
    //MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count //Возврвщвем количество значений массива
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "apiCell", for: indexPath)
        guard let cell = cell as? UserActionCell else { return UICollectionViewCell() }
        cell.userActionLabel.text = userActions[indexPath.item].title // Свойство item возвращает индекс секции. Добавляем свойство title потому что нам нужно строковое значение из перечисления UserAction
        
        
        return cell
    }
    
    
    //MARK: UICollectionViewDelegate
    // Этот метод вызывается когда нажимаем по ячейке и метод принимает индекс ячейки и зная индекс ячейки можем извлечь из массива соответствующий кейс
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item] // вызываем индекс текущей ячейки
        
        //теперь надо определить действие, которое необходимо выполнить
        switch userAction {
            
        case .showImage: performSegue(withIdentifier: "oneSegue", sender: nil)// переход на другой экран по сигвею
        case .fetchGeo:
            fetchGeo()
        case .fetchQuotes:
            fetchQuotes()
        case .nextOne:
            fetchNextOne()
        case .nextTwo:
            fetchNextTwo()
        }
    }
}

// Настраиваем ширину ячеек
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
    
}







//MARK: - Networking
// Эти методы будут вызываться по нажатию на кнопки
extension MainViewController {
    
    private func fetchGeo() {
        URLSession.shared.dataTask(with: Link.geoURL.url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            
            do{
                let something = try decoder.decode(Something.self, from: data)
                print(something)
            } catch let error {
                print(error)
            }
            
            
        }.resume()
    }
    
    private func fetchQuotes() {
        URLSession.shared.dataTask(with: Link.quotesURL.url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            
            do{
                let game = try decoder.decode(Game.self, from: data)
                print(game)
            } catch let error {
                print(error)
            }
            
            
        }.resume()
        
    }
    
    private func fetchNextOne() {
        
    }
    
    private func fetchNextTwo() {
        
    }
}
