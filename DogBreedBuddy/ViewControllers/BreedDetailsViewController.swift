//
//  BreedDetailsViewController.swift
//  DogBreedBuddy
//
//  Created by Mahesh Kumar on 15/12/24.
//

import UIKit
import SDWebImage

class BreedDetailsViewController: UIViewController {
    
    @IBOutlet weak var breedImageListCollectionView: UICollectionView!
    
    private let viewModel = BreedDetailsViewModel()
    private let favouritesStore = FavouritesStore() // Shared store
    
    var breedString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "\(self.breedString)"
        self.view.backgroundColor = .background
        breedImageListCollectionView.register(UINib(nibName: "BreedDetailsCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "BreedDetailsCollectionViewCell")
        breedImageListCollectionView.delegate = self
        breedImageListCollectionView.dataSource = self
        
        viewModel.breedDelegate = self
        viewModel.fetchBreeds(breed: self.breedString)
    }
}


extension BreedDetailsViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.breeds?.message.count ?? 0
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BreedDetailsCollectionViewCell", for: indexPath) as! BreedDetailsCollectionViewCell

        // Extract image URL as a string
        let imageUrlString = viewModel.breeds?.message[indexPath.row] ?? ""
        
        // Convert image URL to URL type
        guard let imageUrl = URL(string: imageUrlString) else {
            fatalError("Invalid URL string: \(imageUrlString)")
        }
        
        // Extract breed name from the URL
        let breedName = extractBreedName(from: imageUrlString) ?? "Unknown Breed"
        
        // Create a FavouriteBreed object
        let breed = FavouriteBreed(
            id: indexPath.row,
            imageUrl: imageUrl,
            breedName: breedName,
            isLiked: favouritesStore.checkIfBreedIsLiked(imageUrl: imageUrl) // Check liked status
        )
        
        // Configure cell
        cell.configureCell(with: breed, favouritesStore: favouritesStore)
        cell.updateFavouriteList = {
            NotificationCenter.default.post(name: .favouriteListUpdated, object: nil)
        }

        // Set the image
        cell.dogImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "WoofyDefaultImage"))
        
        return cell
    }

    // Helper function to extract the breed name from a URL
    private func extractBreedName(from urlString: String) -> String? {
        guard let urlComponents = URL(string: urlString)?.pathComponents else {
            return nil
        }
        return urlComponents.count > 2 ? urlComponents[urlComponents.count - 2] : nil
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 20.0 // Adjust as needed
        let width = (collectionView.bounds.width - spacing) / 2.0
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0 // Adjust as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if let imageURL = viewModel.breeds?.message[indexPath.row] {
            let imagePopupVC = ImagePopupViewController()
            imagePopupVC.imageURL = imageURL
            present(imagePopupVC, animated: true, completion: nil)
        }
    }
}


extension BreedDetailsViewController: BreedServices {
    func reloadData() {
        DispatchQueue.main.async {
            self.breedImageListCollectionView.reloadData()
        }
    }
}


