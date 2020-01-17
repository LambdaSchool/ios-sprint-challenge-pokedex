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
    
    var pokeFunc: PokemonFunctions? {
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
    
    @IBAction func savePokemonButton(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokeFunc?.addPokemon(pokemon: pokemon)
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
        typesLabel.text = "\(types.joined(separator: ", "))"
        abilityLabel.text = "\(pokemonDetail.abilities[0].ability.name)"
        auth?.fetchImage(from: pokemonDetail.images.imageURL, completion: { (pokemonImage) in
            DispatchQueue.main.async {
                self.imageView.image = pokemonImage
            }
        })
    }
}

extension PokeDexDetailViewController: UISearchBarDelegate {
    
}
