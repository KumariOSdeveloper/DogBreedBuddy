//
//  BreedDetailsCollectionViewCell.swift
//  DogBreedBuddy
//
//  Created by Mahesh Kumar on 15/12/24.
//

import UIKit

class BreedDetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    var breed: FavouriteBreed?
    var favouritesStore: FavouritesStore?
    var updateFavouriteList: (() -> Void)?
    
    // to resolve issue
    var isLiked: Bool = false {
        didSet {
            // Update the heart icon based on the isLiked state
            let image = isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            likeButton.setImage(image, for: .normal)
            let tintColor = isLiked ? UIColor.red : UIColor.blue
            likeButton.tintColor = tintColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dogImageView.layer.cornerRadius = 5.0 // Adjust the radius as needed
        dogImageView.layer.masksToBounds = true
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dogImageView.image = nil // Reset the image or any other content
        // Set the system heart icon for the like button
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        
    }
    
    
    func configureCell(with breed: FavouriteBreed, favouritesStore: FavouritesStore) {
        self.breed = breed
        self.favouritesStore = favouritesStore
        
        // Set the isLiked flag from breed
        self.isLiked = breed.isLiked
        
        // Set the like button image based on the initial isLiked value
        let image = isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        likeButton.setImage(image, for: .normal)
        let tintColor = isLiked ? UIColor.red : UIColor.blue
        likeButton.tintColor = tintColor
    }
    
    
    @IBAction func likeAction(_ sender: Any) {
        
        guard let breed = breed else { return }
        
        if isLiked {
            favouritesStore?.removeBreedFromFavourites(imageUrl: breed.imageUrl)
        } else {
            favouritesStore?.addBreedToFavourites(favouriteBreed: breed)
        }
        
        // Toggle isLiked state
        isLiked.toggle()
        
        // Update the button image
        let image = isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        likeButton.setImage(image, for: .normal)
        let tintColor = isLiked ? UIColor.red : UIColor.blue
        likeButton.tintColor = tintColor
        
        // Notify parent view to reload data
        updateFavouriteList?()
    }
    
}

