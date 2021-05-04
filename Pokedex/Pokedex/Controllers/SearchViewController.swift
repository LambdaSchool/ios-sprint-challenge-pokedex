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
    @IBOutlet weak var navItem: UINavigationItem!
    
    var protocolDelegate: AddPokemonDelegate?
    var newPokemon: Pokemon?
    var selectedPokemon: Pokemon?
    var apiController = APIController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if selectedPokemon != nil {
            navItem.title = "Pokemon Detail"
            navItem.backBarButtonItem?.tintColor = UIColor.black
            fetchPokemon(pokemon: selectedPokemon?.name ?? "ditto")
        } else {
            navItem.title = "Pokemon Search"
            navItem.backBarButtonItem?.tintColor = UIColor.black
        }
    }
    
    func fetchPokemon(pokemon: String) {
        apiController.performSearch(searchTerm: pokemon) { error in
            if let error = error {
                print("There was an error: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }


    @IBAction func savePokemonTapped(_ sender: Any) {
        guard let addPokemon = apiController.myPokemon else {return}
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        protocolDelegate?.pokemonWasAdded(addPokemon)
    }
    
    func clearView() {
        if let selectedPokemon = selectedPokemon  {
            updateViews()
        } else {
            DispatchQueue.main.async {
                self.idLabel.text = ""
                self.abilitiesLabel.text = ""
                self.nameLabel.text = ""
            }
        }
    }
    func updateViews() {
        
        if let selectedPokemon = apiController.myPokemon {
          
            let id = String(selectedPokemon.id)
            let abilityCount = selectedPokemon.abilities.count
            guard let ability = selectedPokemon.abilities[0].ability?.name else { return }
            var allAbilities = ""
            for number in 0...abilityCount-1 {
                if abilityCount == 1 {
                    allAbilities = ability
                    break
                }
                guard let addedAbility = selectedPokemon.abilities[number].ability?.name else { return }
                allAbilities = "\(ability), \(addedAbility)"
            }
            guard let typecount = selectedPokemon.types?.count else {return}
            guard let type = selectedPokemon.types?[0].type?.name else { return }
            var newType = ""
            for number in 0...typecount-1 {
                if typecount == 1 {
                    newType = type
                    break}
                guard let addedType = selectedPokemon.types?[number].type?.name else {return}
                newType = "\(type), \(addedType)"
            }
            DispatchQueue.main.async {
                self.idLabel.text = "ID: \(id)"
                self.nameLabel.text = selectedPokemon.name
                self.typesLabel.text = "Type: \(newType)"
                self.abilitiesLabel.text = "Abilites: \(allAbilities)"
                guard let image = selectedPokemon.sprites?.frontDefault else {return}
                //Image
                let url = URL(string: image)!
                let data = try? Data(contentsOf: url)
                
                if let imageData = data {
                    self.pokemonImage.image = UIImage(data: imageData)
                }
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        fetchPokemon(pokemon: searchTerm.lowercased())
    }
    
}
