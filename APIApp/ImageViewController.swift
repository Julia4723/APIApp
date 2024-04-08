//
//  ImageViewController.swift
//  APIApp
//
//  Created by user on 07.04.2024.
//

import UIKit

final class ImageViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
    
    
    //Здесь создаем сетевой запрос
    private func fetchImage() {
        URLSession.shared.dataTask(with: Link.imageURL.url) { [weak self] data, response, error in
            guard let data, let response else {
                print(error?.localizedDescription ?? "No error")
                
                return
            }
            
            print(response)
            
            // Диспетчер очередей, благодаря ему вернулись в основной потоко
            DispatchQueue.main.async {
                self?.imageView.image = UIImage(data: data)
                self?.activityIndicator.stopAnimating()
            }
            
        }.resume()
    }
}
