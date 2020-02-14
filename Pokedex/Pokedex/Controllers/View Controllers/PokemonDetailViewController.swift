//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Tobi Kuyoro on 17/01/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var savePokemon: UIButton!
    
    var apiController: APIController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        searchBar.delegate = self
        
        if pokemon != nil {
            savePokemon.isHidden = true
        }
    }
    
    @IBAction func savePokemonTapped(_ sender: Any) {
        if let pokemon = pokemon,
            let apiController = apiController {
            apiController.savePokemon(called: pokemon)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func updateViews() {
        guard let pokemon = pokemon else {
                title = "Pokemon Search"
                searchBar.placeholder = "Search by name"
                hiddenOutlets()
                return
        }
        
        guard let searchBar = searchBar else { return }
        searchBar.isHidden = true
        visibleOutlets()
        
        var types: [String] = []
        var abilities: [String] = []
        
        for pokemonType in pokemon.types {
            types.append(pokemonType.type.name)
        }
        
        for pokemonAbility in pokemon.abilities {
            abilities.append(pokemonAbility.ability.name)
        }
        
        title = pokemon.name.capitalized
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = "ID: \(pokemon.id)"
        typesLabel.text = "Types: \(types.joined(separator: ", ").capitalized)"
        abilitiesLabel.text = "Abilities: \(abilities.joined(separator: ", ").capitalized)"
        
        guard let imageData = try? Data(contentsOf: pokemon.sprites.picture) else {fatalError()}
        imageView.image = UIImage(data: imageData)
    }
    
    func hiddenOutlets() {
        nameLabel.isHidden = true
        imageView.isHidden = true
        idLabel.isHidden = true
        typesLabel.isHidden = true
        abilitiesLabel.isHidden = true
    }
    
    func visibleOutlets() {
        nameLabel.isHidden = false
        imageView.isHidden = false
        idLabel.isHidden = false
        typesLabel.isHidden = false
        abilitiesLabel.isHidden = false
    }
}

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonName = searchBar.text,
            !pokemonName.isEmpty else {return}
        
        apiController?.fetchPokemon(called: pokemonName, completion: { (result) in
            let pokemon = try? result.get()
            if let pokemon = pokemon {
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews()
                }
            }
        })
    }
}
