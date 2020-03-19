//
//  PokemonDetailViewController.swift
//  PokeDex
//
//  Created by Nichole Davidson on 3/13/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var searchPokemonBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeslabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    // MARK: - Properties
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchPokemonBar.delegate = self
        fetchImage()
        updateViews()
        
    }
    
    //    override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidAppear(animated)
    //        pokemonController?.pokemonSearch(searchTerm: searchTerm, completion: { error in
    //            do {
    //                let pokemonsListed = try searchTerm.get()
    //            }
    //        })
    //    }
    private func updateViews() {
        if pokemon != nil {
            guard let pokemon = pokemon else { return }
            title = pokemon.name
            nameLabel.text = pokemon.name
            idLabel.text = "ID: \(pokemon.id)"
            abilitiesLabel.text = "\(pokemon.abilities)"
        } else {
            self.title = "Pokemon Search"
        }
    }
    
    @IBAction func savePokemonTapped(_ sender: Any) {
        //        var abilitiesArray: [String] = []
        //        abilitiesArray.append(abilitiesLabel.text ?? "")
        //        var joinedArray = abilitiesArray.joined(separator: ", ")
        //
        //        guard let name = nameLabel.text,
        //            let id = Int(idLabel.text ?? ""),
        //            let abilities = joinedArray,
        //            let types = typeslabel.text,
        //            let sprites = pokemonImage.image,
        //            name != ""  else { return }
        
        if let pokemon = pokemon {
            pokemonController?.pokemons.append(pokemon)
            pokemonController?.addPokemonToList(with: pokemon)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func fetchImage() {
        if pokemon != nil {
            pokemonController?.pokemonImage(at: pokemon?.sprites?.name ?? "", completion: { result in
                if let image = try? result.get() {
                    DispatchQueue.main.async {
                        self.pokemonImage.image = image
                    }
                }
            })
        }
    }
}

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        pokemonController?.pokemonSearch(for: searchTerm, completion: { error in
            if let error = error {
                NSLog("Error in search: \(error)")
            } else {
                self.updateViews()
            }
        })
    }
}

