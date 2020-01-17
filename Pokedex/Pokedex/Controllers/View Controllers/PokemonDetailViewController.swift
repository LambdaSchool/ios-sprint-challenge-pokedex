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
    }
    
    @IBAction func savePokemonTapped(_ sender: Any) {
        if let apiController = apiController,
            let pokemon = pokemon {
            apiController.pokemon.append(pokemon)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func updateViews() {
        guard isViewLoaded,
            let pokemon = pokemon else {
            title = "Pokemon Search"
            searchBar.placeholder = "Search by name"
            nameLabel.isHidden = true
            imageView.isHidden = true
            idLabel.isHidden = true
            typesLabel.isHidden = true
            abilitiesLabel.isHidden = true
            
            return
        }
        
        searchBar.isHidden = true
        title = pokemon.name
        nameLabel.text = pokemon.name
        idLabel.text = "ID: \(pokemon.id)"
        typesLabel.text = "Types: \(pokemon.types)"
        abilitiesLabel.text = "Abilities: \(pokemon.abilities)"
        
        guard let imageData = try? Data(contentsOf: pokemon.sprites.picture) else {fatalError()}
        imageView.image = UIImage(data: imageData)
    }
}

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonName = searchBar.text,
            !pokemonName.isEmpty else {return}
        
        apiController?.fetchPokemon(called: pokemonName, completion: { (result) in
            let pokemon = try? result.get()
            DispatchQueue.main.async {
                self.updateViews()
            }
        })
    }
}
