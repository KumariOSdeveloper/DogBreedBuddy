//
//  DogListViewController.swift
//  DogBreedBuddy
//
//  Created by Mahesh Kumar on 15/12/24.
//

import UIKit

class DogListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dogTableView: UITableView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    private let viewModel = BreedViewModel()
    var favouritesStore: FavouritesStore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Breeds"
        
        dogTableView.dataSource = self
        dogTableView.delegate = self
        dogTableView.register(UINib(nibName: "DogListTableViewCell", bundle: nil), forCellReuseIdentifier: "DogListTableViewCell")
        
        viewModel.dogDelegate = self
        viewModel.fetchDogs(url: breedListURL)
        setUpFavouriteButtonView()
        
        self.view.backgroundColor = .background
    }
    
    /// Set up favourite button view
    func setUpFavouriteButtonView() {
        // Set the image on the button (heart icon)
        let heartImage = UIImage(systemName: "heart.fill") // SF Symbol heart filled
        favoriteButton.setImage(heartImage, for: .normal)
        // Change the color of the heart to red
        favoriteButton.tintColor = .red
        
        // Set the title of the button (e.g., "Favorite")
        favoriteButton.setTitle("Favorite pics", for: .normal)
    }
    
    @IBAction func favoriteView(_ sender: Any) {
        
        // Assuming the storyboard name is "Main"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let favourites = favouritesStore?.getFavouriteBreeds() {
            print("Favorites: \(favourites)")
        } else {
            print("No favorites found.")
        }
        
        // Instantiate FavoriteViewController
        if let favoriteVC = storyboard.instantiateViewController(withIdentifier: "FavoriteViewController") as? FavoriteViewController {
            // Push the view controller if using a navigation controller
            navigationController?.pushViewController(favoriteVC, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dogs?.message.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dogTableView.dequeueReusableCell(withIdentifier: "BreedCell", for: indexPath)
        cell.textLabel?.text = viewModel.dogs?.message[indexPath.row]
        // Set the accessory type to show the arrow
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc : BreedDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BreedDetailsViewController") as! BreedDetailsViewController
        vc.breedString = viewModel.dogs?.message[indexPath.row] ?? ""
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension DogListViewController: DogServices {
    func reloadData() {
        DispatchQueue.main.async {
            self.dogTableView.reloadData()
        }
    }
}



