//
//  BreedViewModel.swift
//  DogBreedBuddy
//
//  Created by Mahesh Kumar on 15/12/24.
//

import Foundation

/// A protocol to notify the delegate about updates to dog data.
protocol DogServices: AnyObject {
    /// Called when the dog data needs to be reloaded.
    func reloadData()
}

/// ViewModel responsible for fetching and managing dog breed data.
class BreedViewModel {
    
    /// Instance of `DogAPIManager` to handle API requests.
    private let apiManager = DogAPIManager()
    
    /// Delegate conforming to `DogServices` to notify about data updates.
    weak var dogDelegate: DogServices?
    
    /// Stores the fetched dog breed data. Notifies the delegate when updated.
    var dogs: DogModel? {
        didSet {
            // Notify the delegate to reload data whenever the dogs property is updated.
            self.dogDelegate?.reloadData()
        }
    }
    
    /// Fetches dog breed data from the API.
    ///
    /// This method fetches the dog breeds from the given API URL and updates the `dogs` property. The delegate is notified upon a successful fetch.
    ///
    /// - Parameter url: The API URL to fetch dog breed data.
    @MainActor func fetchDogs(url: String) {
        Task {
            do {
                // Fetch the dog breeds data from the API.
                let dogResponse: DogModel = try await apiManager.getDogBreeds(url: url)
                
                // Update the dogs property with the fetched response.
                self.dogs = dogResponse
            } catch {
                // Handle any errors that occur during the API call.
                print("Error fetching dog breeds: \(error)")
            }
        }
    }
}

