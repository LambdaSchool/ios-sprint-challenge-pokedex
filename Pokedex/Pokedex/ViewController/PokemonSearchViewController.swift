//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Clean Mac on 5/18/20.
//  Copyright © 2020 LambdaStudent. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    
    var pokemonController: PokemonController? {
        didSet {
            updateViews()
        }
    }
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    @IBOutlet weak var pokemonAbilities: UILabel!
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokemonController?.pokemonList.append(pokemon)
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateViews()
    }
    func hideKeyBoard() {
        searchBar.resignFirstResponder()
    
    }
    func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemonObject = pokemon else {
            title = "Pokemon Search"
            return
        }
        
        title = pokemonObject.name
        pokemonName.text = pokemon?.name
        pokemonID.text = "ID: \(pokemonObject.id)"
        
        var types: [String] = []
        for typeInfo in pokemonObject.types {
            types.append(typeInfo.type.name)
        }
        
        pokemonType.text = "\(types.joined(separator: ","))"
        pokemonAbilities.text = "\(pokemonObject.abilities[0].ability.name)"
        
        pokemonController?.fetchImage(from: pokemonObject.sprites.imageUrl, completion: { (pokemonImage) in
            DispatchQueue.main.async {
                self.pokemonImage.image = pokemonImage
            }
        })
    }
    
}


extension PokemonSearchViewController: UISearchBarDelegate {
    
    func searchBarButtonClicked(_ sender: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        pokemonController?.fetchPokemon(searchTerm: searchTerm) { (pokemonObject) in
            guard let pokemon = try? pokemonObject.get() else { return }
            
            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
        }
        
        guard let pokemonImgUrl = pokemon?.sprites.imageUrl else { return }
        pokemonController?.fetchImage(from: pokemonImgUrl, completion: { (pokemonImage) in
            DispatchQueue.main.async {
                self.pokemonImage.image = pokemonImage
            }
            
        })
        
    }
}







