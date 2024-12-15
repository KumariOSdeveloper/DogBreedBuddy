//
//  FavouriteBreedsViewModel.swift
//  DogBreedBuddy
//
//  Created by Mahesh Kumar on 15/12/24.
//

import Foundation

/// Protocol to notify the delegate about updates to favourite breeds.
protocol FavouriteBreedsViewModelDelegate: AnyObject {
    /// Called when the list of favourite breeds is updated.
    /// - Parameter breeds: The updated list of favourite breeds.
    func didUpdateFavouriteBreeds(_ breeds: [FavouriteBreed])
}

/// ViewModel responsible for managing favourite dog breeds.
class FavouriteBreedsViewModel {
    
    /// The list of favourite breeds, updated as changes occur.
    private(set) var favouriteBreeds: [FavouriteBreed] = []
    
    /// Instance of `FavouritesStore` to manage storage of favourite breeds.
    private let favouritesStore = FavouritesStore()
    
    /// Delegate conforming to `FavouriteBreedsViewModelDelegate` to notify about changes in favourite breeds.
    weak var delegate: FavouriteBreedsViewModelDelegate?
    
    /// Loads the list of favourite breeds from the storage.
    ///
    /// This method fetches the favourite breeds from the `FavouritesStore` and updates the `favouriteBreeds` property.
    /// It also notifies the delegate with the updated list.
    func loadFavouriteBreeds() {
        favouriteBreeds = favouritesStore.getFavouriteBreeds() ?? []
        delegate?.didUpdateFavouriteBreeds(favouriteBreeds)
    }
    
    /// Handles the action when the heart icon is tapped for a breed.
    ///
    /// This method removes the selected breed from the favourites list based on the given breed ID.
    /// After removing, it reloads the favourites list and notifies the delegate.
    ///
    /// - Parameter id: The unique ID of the breed to be removed.
    func onHeartTapped(id: Int) {
        // Find the breed with the given ID.
        guard let breed = favouriteBreeds.first(where: { $0.id == id }) else {
            return // Exit if the breed is not found.
        }
        
        // Remove the breed from the favourites.
        favouritesStore.removeBreedFromFavourites(imageUrl: breed.imageUrl)
        
        // Reload the updated favourites list.
        favouriteBreeds = favouritesStore.getFavouriteBreeds() ?? []
        
        // Notify the delegate about the updated list.
        delegate?.didUpdateFavouriteBreeds(favouriteBreeds)
    }
}

