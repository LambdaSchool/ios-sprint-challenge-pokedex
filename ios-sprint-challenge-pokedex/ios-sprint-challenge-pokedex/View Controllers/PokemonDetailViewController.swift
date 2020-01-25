//
//  PokemonDetailViewController.swift
//  ios-sprint-challenge-pokedex
//
//  Created by patelpra on 1/25/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonView: UIView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var savePokemonButton: UIButton!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet {
            self.updateViews()
        }
    }
    
    var detailView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pokemonSearchBar.delegate = self
        if !self.detailView {
            self.pokemonView.isHidden = true
        } else {
            self.pokemonSearchBar.isHidden = true
            self.savePokemonButton.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if detailView {
            self.updateViews()
        }
        
    }
    
    
    // MARK: - Navigation
    
    @IBAction func savePokemon(_ sender: UIButton) {
        guard let pokemon = self.pokemon, isViewLoaded else { return }
        self.pokemonController?.savePokemon(with: pokemon)
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    func updateViews() {
        guard let pokemonController = self.pokemonController,
            let pokemon = self.pokemon, isViewLoaded else { return }
        
        self.title = pokemon.name.capitalized
        self.pokemonNameLabel.text = pokemon.name.capitalized
        self.pokemonIdLabel.text = String(pokemon.id)
        self.typesLabel.text = pokemon.types.map({ $0.type.name }).joined(separator: ", ")
        self.abilitiesLabel.text = pokemon.abilities.map({ $0.ability.name }).joined(separator: ", ")
        
        
        if !self.detailView {
            self.pokemonView.isHidden = false
        }
    }
}

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonController = self.pokemonController,
            let searchTerm = self.pokemonSearchBar.text else { return }
        
        pokemonController.searchPokeman(searchTerm: searchTerm, completion: { (pokemon, error) in
            if let error = error {
                NSLog("Error searching for Pokemon: \(error)")
            }
            
            if let pokemon = pokemon {
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                }
            }
        })
    }
}
