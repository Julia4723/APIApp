//
//  GameCell.swift
//  APIApp
//
//  Created by user on 11.04.2024.
//

import UIKit


final class GameViewController: UITableViewController {
    
    var games: [Game] = []
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 200
        
    }
    
    //MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        games.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quotesCell", for: indexPath)
        guard let cell = cell as? GameCell else { return
            UITableViewCell() }

        //Извлекаем экземпляр ячейки из массива по индексу строки
        let game = games[indexPath.row]
        cell.configure(game: game) //передаем данные в кастомную ячейку
        
        return cell
        
    }
    
}

//MARK: - Networking
extension GameViewController {
  
      func showQuotes() {
        networkManager.fetchQuotes(from: Link.quotesURL.url) { [unowned self] result in
            switch result {
            case .success(let game):
                self.games = game
                tableView.reloadData()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    
    
    /*
    func showQuotes() {
        networkManager.fetch(Game.self, from: Link.quotesURL.url) { [weak self] result in
            switch result {
                
            case .success(let game):
                self?.games = [game]
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    */
    
}
