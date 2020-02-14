//
//  PokeDexDetailTableViewController.swift
//  PokeDex
//
//  Created by Aaron Cleveland on 1/17/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import UIKit

class PokeDexDetailViewController: UIViewController {
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    var auth: Auth? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var titleLabelText: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        searchBar.delegate = self
    }
    
    @IBAction func savePokemonButton(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        auth?.addPokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        guard isViewLoaded,
            let pokemonDetail = pokemon else {
                title = "Pokemon Search"
                return }
        
        var types: [String] = []
        for typeInfo in pokemonDetail.types {
            types.append(typeInfo.type.name)
        }
        
        title = pokemonDetail.name.capitalized
        titleLabelText.text = pokemon?.name
        idLabel.text = "ID: \(pokemonDetail.id)"
        typesLabel.text = "Types: \(types.joined(separator: ", "))"
        abilityLabel.text = "Ability: \(pokemonDetail.abilities[0].ability.name)"
        auth?.fetchImage(from: pokemonDetail.sprites.imageURL, completion: { (pokemonImage) in
            DispatchQueue.main.async {
                self.imageView.image = pokemonImage
            }
        })
    }
}

extension PokeDexDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        auth?.fetchPokemon(pokemonName: searchTerm, completion: { (pokemonDetail) in
            guard let pokemon = try? pokemonDetail.get() else { return }
            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
        })
        
        guard let pokemonImageURL = pokemon?.sprites.imageURL else { return }
        auth?.fetchImage(from: pokemonImageURL, completion: { (pokemonImage) in
            DispatchQueue.main.async {
                self.imageView.image = pokemonImage
            }
        })
    }
}
