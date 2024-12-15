//
//  DogAPIManager.swift
//  DogBreedBuddy
//
//  Created by Mahesh Kumar on 15/12/24.
//

import UIKit

/// Represents potential errors that can occur while making API requests.
enum APIError: Error {
    /// The provided URL is invalid.
    case invalidURL
    
    /// The response received is invalid or unexpected.
    case invalidResponse
    
    /// The data received is invalid or cannot be processed.
    case invalidData
}

/// A class responsible for managing API calls related to dog breeds.
class DogAPIManager {
    
    /// Fetches the list of dog breeds from the provided API URL.
    ///
    /// This method retrieves data from the API and decodes it into a `DogModel` object.
    /// - Parameter url: The string URL of the API endpoint to fetch the breed list.
    /// - Returns: A `DogModel` object containing the list of dog breeds.
    /// - Throws: An `APIError` if the URL is invalid, the response is not successful, or decoding fails.
    func getDogBreeds(url: String) async throws -> DogModel {
        // Validate the URL.
        guard let url = URL(string: url) else {
            throw APIError.invalidURL
        }
        
        // Perform the API request.
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Check if the response status code is valid.
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        // Decode the response data into a `DogModel`.
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(DogModel.self, from: data)
            return decodedData
        } catch {
            throw APIError.invalidData
        }
    }
    
    /// Fetches dog breed images from the provided API URL.
    ///
    /// This method retrieves data from the API and decodes it into a `Breed` object.
    /// - Parameter url: The string URL of the API endpoint to fetch the breed images.
    /// - Returns: A `Breed` object containing the breed images.
    /// - Throws: An `APIError` if the URL is invalid, the response is not successful, or decoding fails.
    func getDogBreedsImages(url: String) async throws -> Breed {
        // Validate the URL.
        guard let url = URL(string: url) else {
            throw APIError.invalidURL
        }
        
        // Perform the API request.
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Check if the response status code is valid.
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        // Decode the response data into a `Breed`.
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(Breed.self, from: data)
            return decodedData
        } catch {
            throw APIError.invalidData
        }
    }
}

