//
//  GameCell.swift
//  APIApp
//
//  Created by user on 11.04.2024.
//

import UIKit

final class GameViewController: UITableViewController {
    
    private var game: [Game] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
    }
    
    //MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        game.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
        guard let cell = cell as? GameCell else { return
            UITableViewCell() }
        
        let game = game[indexPath.row]
        cell.configure(with: game)
        
        return cell
        
    }
    
}

//MARK: - Networking
extension GameViewController {
    func fetchQuotes() {
        URLSession.shared.dataTask(with: Link.quotesURL.url) {
             [weak self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error descr" )
                return
            }
            
            do {
                let decoder = JSONDecoder()
                self?.game = try decoder.decode([Game].self, from: data)
                
                //Возвращаемся в основной поток, чтобы обновить данные
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
                
            }
        }.resume()
        
    }
}
