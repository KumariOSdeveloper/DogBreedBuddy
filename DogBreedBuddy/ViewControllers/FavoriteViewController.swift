//
//  FavoriteViewController.swift
//  DogBreedBuddy
//
//  Created by Mahesh Kumar on 15/12/24.
//

import UIKit
import SDWebImage

class FavoriteViewController: UIViewController {

    @IBOutlet weak var breedFavoriteListCollectionView: UICollectionView!
    
    @IBOutlet weak var filteredByBreed: UIButton!
    
    @IBOutlet weak var filteredLabel: UILabel!
    
    private var favouriteBreeds: [FavouriteBreed] = []
    private let favouritesStore = FavouritesStore()

    // Array to store unique breed names for filtering
    var arrayForFilterListFromFavouriteBreedbreedName: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .background
        filteredLabel.text = "All Breeds"
        setUpFilterButtonView()
        breedFavoriteListCollectionView.register(UINib(nibName: "FavoriteListTableViewCell", bundle: .main), forCellWithReuseIdentifier: "FavoriteListTableViewCell")
        breedFavoriteListCollectionView.delegate = self
        breedFavoriteListCollectionView.dataSource = self
        
        loadFavourites() // Call manually in viewDidLoad
        NotificationCenter.default.addObserver(self, selector: #selector(loadFavourites), name: .favouriteListUpdated, object: nil)
    }
    
    /// Set up favourite button view
    func setUpFilterButtonView() {
        // Set the image on the button (heart icon)
        let heartImage = UIImage(systemName: "line.3.horizontal.decrease.circle") // SF Symbol heart filled
        filteredByBreed.setImage(heartImage, for: .normal)
        // Change the color of the heart to red
        filteredByBreed.tintColor = .blue
        
        // Set the title of the button (e.g., "Favorite")
        filteredByBreed.setTitle("Filter By Breed", for: .normal)
    }
    
    
    ///  Load loadFavourites view
    @objc func loadFavourites() {
        // Fetch all favourite breeds
        favouriteBreeds = favouritesStore.getFavouriteBreeds() ?? []
        
        // Extract unique breed names for filtering
        arrayForFilterListFromFavouriteBreedbreedName = Array(Set(favouriteBreeds.map { $0.breedName })).sorted()
        
        print("Favourite breeds count: \(favouriteBreeds.count)") // Debug log
        // Update UI after loading favourites
        didUpdateFavouriteBreeds(favouriteBreeds)
        breedFavoriteListCollectionView.reloadData()
    }
    
    /// Updates the UI based on the current state of the favourite breeds list.
    /// - Parameter breeds: An array of `FavouriteBreed` objects representing the current favourite breeds.
    func didUpdateFavouriteBreeds(_ breeds: [FavouriteBreed]) {
        if breeds.isEmpty {
            filteredByBreed.isHidden = true
            filteredLabel.text = "No Favourite pics yet"
        } else {
            filteredByBreed.isHidden = false
            filteredLabel.text = "All Breeds" // Or set it to a relevant message
        }
    }
    
    
    @IBAction func filteredByBreedAction(_ sender: Any) {
        
        // Create an alert controller to display filter options
        let alertController = UIAlertController(title: "Filter by Breed", message: nil, preferredStyle: .alert)
        
        // Add an option for each unique breed name
        for breedName in arrayForFilterListFromFavouriteBreedbreedName {
            let action = UIAlertAction(title: breedName, style: .default) { [weak self] _ in
                self?.filterFavourites(by: breedName)
                self?.filteredLabel.text = "\(breedName)" // Update filteredLabel with selected breed name
            }
            alertController.addAction(action)
        }
        
        // Add an option to reset the filter
        let resetAction = UIAlertAction(title: "Reset Filter", style: .cancel) { [weak self] _ in
            self?.loadFavourites() // Reload all favourites
            self?.filteredLabel.text = "All Breeds" // Reset filteredLabel to show "All Breeds"
        }
        alertController.addAction(resetAction)
        
        // Add a cancel button to dismiss the alert without any action
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertController.addAction(cancelAction)
        
        // Present the alert
        present(alertController, animated: true, completion: nil)
    }
    
    private func filterFavourites(by breedName: String) {
        // Filter the favourites based on the selected breed name
        favouriteBreeds = favouritesStore.getFavouriteBreeds()?.filter { $0.breedName == breedName } ?? []
        breedFavoriteListCollectionView.reloadData()
    }

}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouriteBreeds.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Dequeue the correct type of cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteListTableViewCell", for: indexPath) as! FavoriteListTableViewCell
        
        // Get the breed object
        let breed = favouriteBreeds[indexPath.row]
        
        // Configure cell
        cell.configureCell(with: breed, favouritesStore: favouritesStore)
        // Set the image using SDWebImage, passing the imageUrl string directly
        cell.dogImageView.sd_setImage(with: breed.imageUrl, placeholderImage: UIImage(named: "WoofyDefaultImage"))
        
        // Return the cell of the correct type
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 20.0 // Adjust as needed
        let width = (collectionView.bounds.width - spacing) / 2.0
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0 // Adjust as needed
    }

}
