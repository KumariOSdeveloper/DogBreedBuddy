//
//  FavouriteBreed.swift
//  DogBreedBuddy
//
//  Created by Mahesh Kumar on 15/12/24.
//

import Foundation

class FavouriteBreed : Codable{
    var id: Int
    var imageUrl: URL
    var breedName: String
    var isLiked: Bool // Track like state for each breed

    init(id: Int, imageUrl: URL, breedName: String, isLiked: Bool = false) {
        self.id = id
        self.imageUrl = imageUrl
        self.breedName = breedName
        self.isLiked = isLiked
    }
}

