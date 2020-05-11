//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Nonye on 5/8/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

import UIKit
import Foundation

class PokemonDetailViewController: UIViewController {
    
    var pokemonController: PokemonController? {
        didSet {
            updateViews()
            //TODO
        }
    }
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var ability: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateViews()
    }
    
    // MARK: - ACTION
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        
        pokemonController?.addPokemon(pokemon: pokemon)
        //GO TO POI PROJECT TO PASS INFO FROM VC TO TV
        
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemonLiteral = pokemon else {
            title = "Search Pokemon"
            return
        }
        
        title = pokemonLiteral.name.capitalized
        name.text = pokemon?.name
        id.text = "ID: \(pokemonLiteral.id)"
        
        var types: [String] = []
        for typeLiteral in pokemonLiteral.types {
            types.append(typeLiteral.type.name)
        }
        type.text = "\(types.joined(separator: ","))"
        ability.text = "Ability: \(pokemonLiteral.abilities[0].ability.name)"
        
        pokemonController?.fetchImage(imageURL: pokemonLiteral.sprites.imageUrl, completion: { (pokemonImage) in  // TODO
            DispatchQueue.main.async {
                self.image.image = pokemonImage
            }
        })
    }
}

// MARK: - EXTENSION
extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ sender: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        pokemonController?.fetchPokemon(name: searchTerm) { (pokemonLiteral) in
            
            guard let pokemon = try? pokemonLiteral.get() else { return }
            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
        }
        guard let pokemonImageURL = pokemon?.sprites.imageUrl else { return }
        pokemonController?.fetchImage(imageURL: pokemonImageURL, completion: { (pokemonImage) in
            DispatchQueue.main.async {
                self.image.image = pokemonImage
            }
        })
    }
}

