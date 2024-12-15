//
//  ImagePopupViewController.swift
//  DogBreedBuddy
//
//  Created by Mahesh Kumar on 15/12/24.
//

import UIKit
import SDWebImage

class ImagePopupViewController: UIViewController {
    
    private let largeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(closePopup), for: .touchUpInside)
        return button
    }()
    
    var imageURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        if let imageURL = imageURL {
            largeImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "WoofyDefaultImage"))
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(largeImageView)
        view.addSubview(closeButton)
        
        largeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            largeImageView.topAnchor.constraint(equalTo: view.topAnchor),
            largeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            largeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            largeImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @objc private func closePopup() {
        dismiss(animated: true, completion: nil)
    }
}
