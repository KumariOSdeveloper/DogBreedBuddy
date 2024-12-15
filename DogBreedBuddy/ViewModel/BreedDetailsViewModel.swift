//
//  BreedDetailsViewModel.swift
//  DogBreedBuddy
//
//  Created by Mahesh Kumar on 15/12/24.
//

import Foundation

/// A protocol to notify the delegate about data updates.
protocol BreedServices: AnyObject {
    /// Called when the data needs to be reloaded.
    func reloadData()
}

/// ViewModel responsible for fetching and managing breed details.
class BreedDetailsViewModel {
    
    /// Instance of `DogAPIManager` to handle API requests.
    private let apiManager = DogAPIManager()
    
    /// Delegate conforming to `BreedServices` to notify about updates.
    weak var breedDelegate: BreedServices?
    
    /// A dictionary to store preloaded image URLs for breeds.
    var imageUrls: [String: String] = [:]
    
    /// Stores the fetched breed details. Notifies the delegate when updated.
    var breeds: Breed? {
        didSet {
            // Notify the delegate to reload data when breeds are updated.
            self.breedDelegate?.reloadData()
        }
    }
    
    /// Fetches images of the specified breed from the API.
    ///
    /// This method fetches a list of random images for the given breed and updates the `breeds` property. The delegate is notified when the data is successfully fetched.
    ///
    /// - Parameter breed: The name of the breed to fetch images for.
    @MainActor func fetchBreeds(breed: String) {
        // Construct the API URL to fetch breed images.
        let imageURL = "https://dog.ceo/api/breed/\(breed)/images/random/16"
        
        Task {
            do {
                // Fetch the breed images from the API.
                let breedResponse: Breed = try await apiManager.getDogBreedsImages(url: imageURL)
                
                // Update the breeds property with the fetched response.
                self.breeds = breedResponse
            } catch {
                // Handle any errors that occur during the API call.
                print("Error fetching breed images: \(error)")
            }
        }
    }
}

