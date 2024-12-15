//
//  FavoriteListTableViewCell.swift
//  DogBreedBuddy
//
//  Created by Mahesh Kumar on 15/12/24.
//

import UIKit

class FavoriteListTableViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    var breed: FavouriteBreed?
    var favouritesStore: FavouritesStore?
    var isLiked: Bool = false {
        didSet {
            // Update heart icon based on the isLiked state
            let image = isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            likeButton.setImage(image, for: .normal)
            likeButton.tintColor = .red
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dogImageView.layer.cornerRadius = 5.0 // Adjust the radius as needed
        dogImageView.layer.masksToBounds = true
        let image = UIImage(systemName: "heart.fill") // Use SF Symbols heart icon
        likeButton.setImage(image, for: .normal)
        let tintColor = isLiked ? UIColor.red : UIColor.gray
        likeButton.tintColor = tintColor
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dogImageView.image = nil // Reset the image or any other content
        // Set the system heart icon for the like button
        likeButton.setTitle("", for: .normal)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .red
    }
    
    
    func configureCell(with breed: FavouriteBreed, favouritesStore: FavouritesStore) {
        self.breed = breed
        self.favouritesStore = favouritesStore
        
        // Check if breed is liked using the breed's imageUrl
        isLiked = favouritesStore.checkIfBreedIsLiked(imageUrl: breed.imageUrl)
    }
    
    @IBAction func likeAction(_ sender: Any) {
        guard let breed = breed else {
            print("Breed is nil in likeAction")  // Debugging line
            return
        }

        // Toggle like/unlike status based on isLiked
        if isLiked {
            favouritesStore?.removeBreedFromFavourites(imageUrl: breed.imageUrl)
        } else {
            favouritesStore?.addBreedToFavourites(favouriteBreed: breed)
        }

        // Update isLiked flag to update UI
        isLiked.toggle()

        // Notify that the favourite list has been updated
        NotificationCenter.default.post(name: .favouriteListUpdated, object: nil)
    }
}

