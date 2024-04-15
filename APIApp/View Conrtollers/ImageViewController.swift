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
        NetworkManager.shared.fetchImage(from: Link.imageURL.url) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.imageView.image = UIImage(data: imageData)
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
}
