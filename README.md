
DogBreedBuddy

DogBreedBuddy is the ultimate iOS app for dog enthusiasts and animal lovers! This app provides a comprehensive list of dog breeds, allowing users to explore and discover various breeds. 
Select your favorite breed, and enjoy a curated collection of adorable and random images showcasing the breed's charm.
Whether you're looking to learn more about dogs or just enjoy browsing through cute dog photos, DogBreedBuddy is the perfect companion for every dog lover!

Getting Started

API Integration
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


Installation

Prerequisites

Xcode, Swift, Cocoapods

Installing

	1	Clone the repository: through zip
	2	Open the project in Xcode: cd DogBreedBuddy and then open DogBreedBuddy.xcworkspace
	3	Then Build and Run the app in the Xcode simulator or on a connected device.


View Details with functionality 

DogListViewController
	•	Purpose: This view controller displays a list of all available dog breeds.
	•	Key Features:
	•	Displays a collection of dog breeds ( shown as a UITableView ).
	•	Tapping on a breed opens BreedDetailsViewController, where users can view detailed information and images for that breed.
	•	Fetches the list of dog breeds from an API and shows them in a dynamic list.
	•	Allows users to select favourites dogs of each breed by tapping heart icon and if user want to unselect then also can do.
	•	Can display an image pop up view of dogs by tapping cell.


BreedDetailsViewController
	•	Purpose: This view controller displays detailed information about a selected dog breed.
	•	Key Features:
	•	Shows the image pop up view of dogs by tapping cell opens ImagePopupViewController.
	•	Displays a collection of random images of the selected breed (fetched from an external API) for now showing atleaset 16.
	•	Provides functionality to add the breed to the user's favorites list.
	•	Offers a smooth user interface with a clean layout for easy navigation.
	•	This controller makes API calls to fetch images and breed details dynamically.

ImagePopupViewController
	•	Purpose: This view controller is responsible for displaying a large image in a full-screen popup view.
	•	Key Features:
	•	Displays a large image in a UIImageView that fills the entire screen.
	•	The image is fetched from a provided URL (imageURL) using SDWebImage for asynchronous image loading and caching.
	•	Includes a Close button at the top-right corner of the screen to dismiss the popup when tapped.
	•	The background color is set to white for a clean, minimalistic view of the image.
	•	The UIImageView is set to scaleAspectFill mode, ensuring the image maintains its aspect ratio and fills the screen, cropping if necessary.
	•	The UIButton (Close button) triggers the dismissal of the popup when tapped, providing an easy way for users to close the view.

FavoriteViewController
	•	Purpose: This view controller is responsible for displaying and managing the list of the user's favorite dog breeds. It allows users to view, filter, and remove breeds from their favorite list.
	•	Key Features:
	•	Displays a List of Favorite Breeds: The view controller shows a list of breeds that the user has marked as favorites, helping them keep track of their preferred breeds.
	•	Remove Breeds from Favorites: Users can easily remove breeds from the favorites list with a tap, allowing for dynamic management of the list.
	•	Dynamic List Updates: The list is automatically updated whenever a breed is added or removed from favorites, ensuring the UI reflects the latest data.
	•	No Favorites Message: If the user has not added any breeds to their favorites, a message such as "No Favorite Breeds Yet" is displayed, giving clear feedback.
	•	Uses UserDefaults for Persistence: Favorite breeds data is persisted locally using UserDefaults, ensuring that the list remains intact even when the app is restarted.
	•	Filter by Breed Name:
	•	Filtered by Breed Action: This feature allows the user to filter the list of favorite breeds based on their name. When the user taps on the filter option, an alert is presented with a list of available breed names.
	•	Implementation Details:
	•	Alert Controller: The filteredByBreedAction method triggers an alert controller that displays a list of available breed names (from arrayForFilterListFromFavouriteBreedbreedName). Each breed name is added as an option in the alert.
	•	Breed Selection: When a breed name is selected, the filterFavourites(by:) method is called to filter the favorite breeds list based on the selected breed name. Additionally, the filteredLabel is updated to show the selected breed's name.
	•	Reset Filter: An option to reset the filter is included in the alert. When the user taps "Reset Filter," the loadFavourites() method reloads all favorite breeds, and the filteredLabel is reset to display "All Breeds."
	•	Cancel Option: A "Cancel" option is available to dismiss the filter alert without taking any action.

