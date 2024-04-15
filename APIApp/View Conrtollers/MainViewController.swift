//
//  MainViewController.swift
//  APIApp
//
//  Created by user on 07.04.2024.
//

import UIKit


enum Link {
    case imageURL
    case quotesURL
    case postRequest

    
    var url: URL {
        switch self {
        case .imageURL:
            return URL(string: "https://http.cat/images/414.jpg")!
        case .quotesURL:
            return URL(string: "https://api.gameofthronesquotes.xyz/v1/random")!
        case .postRequest:
            return URL(string: "https://jsonplaceholder.typicode.com/posts")!
        }
    }
}

enum UserAction: CaseIterable {
    case showImage
    case fetchQuotes
    case showQuotes
    case postRequestWithDict
    case postRequestModel

    
    var title: String {
        switch self {
        case .showImage:
            return "Show Image"
        case .fetchQuotes:
            return "Quotes in console"
        case .showQuotes:
            return "Random Quotes"
        case .postRequestWithDict:
            return "POSR RQST with Dict"
        case .postRequestModel:
            return "POSR RQST Model"

        }
    }
}

enum Alert {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .failed:
            return "Failed"
        }
    }
    
    var message: String {
        switch self {
        case .success:
            return "You can see the results in the Debug aria"
        case .failed:
            return "You can see error in the Debug aria"
        }
    }
}

final class MainViewController: UICollectionViewController {
    private let userActions = UserAction.allCases //Массив с кейсами перечислений
    private let networkManager = NetworkManager.shared
    
    
    //MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count //Возвращаем количество значений массива
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "apiCell", for: indexPath)
        guard let cell = cell as? UserActionCell else { return UICollectionViewCell() }
        cell.userActionLabel.text = userActions[indexPath.item].title // Свойство item возвращает индекс секции. Добавляем свойство title потому что нам нужно строковое значение из перечисления UserAction
        
        
        return cell
    }
    
    
    
    
    //MARK: - UICollectionViewDelegate
    // Этот метод вызывается когда нажимаем по ячейке и метод принимает индекс ячейки и зная индекс ячейки можем извлечь из массива соответствующий кейс
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item] // вызываем индекс текущей ячейки
        
        //теперь надо определить действие, которое необходимо выполнить
        switch userAction {
        case .showImage: performSegue(withIdentifier: "oneSegue", sender: nil)// переход на другой экран по сигвею
        case .fetchQuotes: fetchQuotes()
        case .showQuotes: performSegue(withIdentifier: "showQuotes", sender: nil) // переход на другой экран по сигвею
        case .postRequestWithDict: postRequestWithDict()
        case .postRequestModel: postRequestModel()

        }
    }
        
        //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuotes" {
            let gameVC = segue.destination as? GameViewController
            gameVC?.fetchQuotes()
        }
    }
        
    // MARK: - Private Methods
    private func showAlert(withStatus status: Alert) {
        let alert = UIAlertController(
            title: status.title,
            message: status.message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        DispatchQueue.main.async { [unowned self] in
            present(alert, animated: true)
        }
    }
    
}
    
    
    // MARK: - MainViewController
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
    
    private func fetchQuotes() {
        networkManager.fetch(Game.self, from: Link.quotesURL.url) {[weak self] result in
            switch result {
                
            case .success(let game):
                print(game)
                self?.showAlert(withStatus: .success)
            case .failure(let error):
                print(error)
                self?.showAlert(withStatus: .failed)
            }
        }
    }
    
    
    private func postRequestWithDict() {
        let parameters = [
        "name": "Networking",
        "imageURL": "image url",
        "numberOfTests": "8"
        ]
        
        networkManager.postRequest(with: parameters, to: Link.postRequest.url) { [weak self] result in
            switch result {
            case .success(let json):
                print(json)
                self?.showAlert(withStatus: .success)
            case .failure(let error):
                print(error)
                self?.showAlert(withStatus: .failed)
            }
        }
    }
    
    private func postRequestModel() {
        let game = Game(
            sentence: "Quotes",
            character: Character.init(
                name: "Name",
                slug: "slag",
                house: House(
                    name: "Name",
                    slug: "Slag"
                )
            )
        )
                
                networkManager.postRequest(with: game, to: Link.postRequest.url) { result in
                    switch result {
                    case .success(let game):
                        print(game)
                        self.showAlert(withStatus: .success)
                    case .failure(let error):
                        print(error)
                        self.showAlert(withStatus: .failed)
                    }
                }
    }
    
}
