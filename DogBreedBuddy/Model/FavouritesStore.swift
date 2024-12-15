//
//  FavouritesStore.swift
//  DogBreedBuddy
//
//  Created by Mahesh Kumar on 15/12/24.
//

import Foundation

/// A class that manages storing, retrieving, and updating favourite breeds in UserDefaults.
class FavouritesStore {
    
    // MARK: - Properties
    
    private var favouritesKey = "FavouritesKey" // The key used to store favourite breeds data in UserDefaults.
    private var userDefaults = UserDefaults.standard // The shared UserDefaults instance for persistent storage.
    
    // MARK: - Methods
    
    /// Retrieves the list of favourite breeds from UserDefaults.
    ///
    /// - Returns: An optional array of `FavouriteBreed` objects if found in UserDefaults, otherwise nil.
    func getFavouriteBreeds() -> [FavouriteBreed]? {
        do {
            let decoder = JSONDecoder() // JSON decoder to decode the data.
            if let favouritesBreedsData = userDefaults.data(forKey: favouritesKey) {
                // Decode the stored data into an array of `FavouriteBreed` objects.
                let decodedFavouritesBreeds = try decoder.decode([FavouriteBreed].self, from: favouritesBreedsData)
                print("Decoded favourites: \(decodedFavouritesBreeds)") // Log to confirm
                return decodedFavouritesBreeds
            }
            return nil
        } catch {
            print("Error decoding favourites: \(error)") // Log the error if decoding fails.
            return nil
        }
    }
    
    /// Saves the provided array of favourite breeds to UserDefaults.
    ///
    /// - Parameter favouritesBreedsArray: The array of `FavouriteBreed` objects to be saved.
    private func saveFavouriteBreeds(favouritesBreedsArray: [FavouriteBreed]) {
        do {
            let encoder = JSONEncoder() // JSON encoder to encode the array of breeds into data.
            let encodedFavouritesBreedsData = try encoder.encode(favouritesBreedsArray)
            userDefaults.set(encodedFavouritesBreedsData, forKey: favouritesKey) // Store the encoded data.
        } catch {
            print("Error saving favourites: \(error)") // Log the error if encoding fails.
        }
    }
    
    /// Adds a breed to the favourites list, marking it as liked.
    ///
    /// - Parameter favouriteBreed: The `FavouriteBreed` object to be added to the favourites.
    func addBreedToFavourites(favouriteBreed: FavouriteBreed) {
        let updatedBreed = favouriteBreed
        updatedBreed.isLiked = true // Mark the breed as liked.
        
        if var decodedFavouritesBreeds = getFavouriteBreeds() {
            // If favourites exist, check if the breed is already in the list by image URL.
            if !decodedFavouritesBreeds.contains(where: { $0.imageUrl == favouriteBreed.imageUrl }) {
                decodedFavouritesBreeds.append(updatedBreed) // Add the breed if not already in favourites.
                saveFavouriteBreeds(favouritesBreedsArray: decodedFavouritesBreeds) // Save the updated list.
            }
        } else {
            // If no favourites exist, create a new list and save the breed.
            saveFavouriteBreeds(favouritesBreedsArray: [updatedBreed])
        }
    }
    
    /// Removes a breed from the favourites list based on its image URL.
    ///
    /// - Parameter imageUrl: The image URL of the breed to be removed from favourites.
    func removeBreedFromFavourites(imageUrl: URL) {
        if var decodedFavouritesBreeds = getFavouriteBreeds() {
            // Remove the breed with the specified image URL.
            decodedFavouritesBreeds.removeAll { $0.imageUrl == imageUrl }
            saveFavouriteBreeds(favouritesBreedsArray: decodedFavouritesBreeds) // Save the updated list.
        }
    }
    
    /// Checks if a breed is marked as liked in the favourites list.
    ///
    /// - Parameter imageUrl: The image URL of the breed to check.
    /// - Returns: `true` if the breed is found in the favourites list, `false` otherwise.
    func checkIfBreedIsLiked(imageUrl: URL) -> Bool {
        guard let decodedFavouritesBreeds = getFavouriteBreeds() else { return false }
        // Check if the breed is in the favourites list.
        return decodedFavouritesBreeds.contains(where: { $0.imageUrl == imageUrl })
    }
}

