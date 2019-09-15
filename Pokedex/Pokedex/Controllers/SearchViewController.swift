//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Aaron on 9/14/19.
//  Copyright © 2019 AlphaGrade, INC. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var delegate: [Pokemon]?
    var newPokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    var apiController = APIController()

    override func viewDidLoad() {
        super.viewDidLoad()
        clearView()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func savePokemonTapped(_ sender: Any) {
        if let newPokemon = apiController.myPokemon {
            delegate?.append(newPokemon)
        }
        dismiss(animated: true)
    }
    
    func clearView() {
        idLabel.text = "ID:"
        abilitiesLabel.text = "Abilities:"
        nameLabel.text = "Pokemon"
    }
    
    func updateViews() {
        if let newPokemon = newPokemon {
            let id = String(newPokemon.id)
            self.idLabel.text = "ID: \(id)"
            self.nameLabel.text = newPokemon.name
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
    
        apiController.performSearch(searchTerm: searchTerm) { error in
            if let error = error {
                print("There was an error: \(error)")
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.newPokemon = self.apiController.myPokemon
            }
        }
    }
}
