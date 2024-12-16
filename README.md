# DogBreedBuddy

DogBreedBuddy is the ultimate iOS app for dog enthusiasts and animal lovers! This app provides a comprehensive list of dog breeds, allowing users to explore and discover various breeds. 
Select your favorite breed, and enjoy a curated collection of adorable and random images showcasing the breed's charm.
Whether you're looking to learn more about dogs or just enjoy browsing through cute dog photos, DogBreedBuddy is the perfect companion for every dog lover!

## Getting Started

# API Integration
DogBreedBuddy uses the Dog API to fetch information about hundreds of dog breeds. The API has different endpoints to retrieve different data about the dog breeds. Below are two endpoints used to fetch a list of dog breeds and random images of a dog breed.

GET 'https://dog.ceo/api/breeds/list' 
GET 'https://dog.ceo/api/breed/{name}/images'

Technologies Used

The app is built with the following:
	•	Swift - programming language for iOS development.
	•	UIKit - this is an iOS framework used to build user interface. The user interfaces were built using Storyboard, UITableView, UICollectionView.
	•	Asynchronous URLSession - this is used to make calls to the API and to get responses / data which are then implemented in the app.
	•	SDWebImage - This is a third party library which is asynchronous image downloader used to fetch random images from the URL endpoint and also provides caching.
	•	UserDefault -  Implemented to save users' favorite breeds locally, allowing users to retain their preferences even after restarting the app.


## Installation

# Prerequisites

Xcode, Swift, Cocoapods

# Installing

	1	Clone the repository: (https://github.com/KumariOSdeveloper/DogBreedBuddy/tree/main)
	2	Open the project in Xcode: cd DogBreedBuddy and then open DogBreedBuddy.xcworkspace
	3	Then Build and Run the app in the Xcode simulator or on a connected device.

https://github.com/user-attachments/assets/2543198a-f6d4-4a08-9ff4-97896610566b
