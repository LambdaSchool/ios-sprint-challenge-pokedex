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
    var newPokemon: Pokemon?
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
        self.dismiss(animated: true, completion: nil)
    }
    
    func clearView() {
        idLabel.text = "ID:"
        abilitiesLabel.text = "Abilities:"
        nameLabel.text = "Pokemon"
    }
    
    func updateViews() {
        
        if let newPokemon = apiController.myPokemon {
            let id = String(newPokemon.id)
            guard let ability = newPokemon.abilities[0].ability?.name else { return }
            guard let type = newPokemon.types?[0].type?.name else { return }
            print(type)
            self.idLabel.text = "ID: \(id)"
            self.nameLabel.text = newPokemon.name
            self.typesLabel.text = "Type: \(type)"
            self.abilitiesLabel.text = "Abilites: \(ability)"

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
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
       
    }
    
}
