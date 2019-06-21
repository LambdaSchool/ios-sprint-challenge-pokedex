//
//  PokemonSearchViewController.swift
//  ios-sprint3-challenge
//
//  Created by De MicheliStefano on 10.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateViews()
    }
    
    
    // MARK: - Methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchInput = searchBar.text else { return }
        
        pokemonController?.fetchPokemons(for: searchInput, completion: { (error) in
            if let error = error {
                NSLog("Error while fetching pokemon: \(error)")
                return
            }
            //print(self.pokemonController?.pokemon)
            DispatchQueue.main.async {
                self.updateViews()
            }
        })
    }
    
    @IBAction func save(_ sender: Any) {
        pokemonController?.save()
        navigationController?.popViewController(animated: true)
    }
    
    private func fetchImage(_ pokemon: Pokemon) {
        pokemonController?.getDataFromURL(url: URL(string: pokemon.sprites.front_default)!, completion: { (data, error) in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.imageView?.image = UIImage(data: data)
                self.updateViews()
            }
        })
    }
    
    private func updateViews() {
        
        if let pokemon = pokemon {
            fetchImage(pokemon)
            
            title = pokemon.name
            nameTextLabel?.text = pokemon.name
            
            identifierTextLabel?.text = "ID: \(String(pokemon.id))"
            
            let types = pokemon.types.map { $0.type.name }.joined(separator: ", ")
            typeTextLabel?.text = "Types: \(types)"
            
            let abilities = pokemon.abilities.map { $0.ability.name }.joined(separator: ", ")
            abilitiesTextLabel?.text = "Abilities: \(abilities)"
            
            buttonTextLabel?.setTitle("Save Pokemon", for: .normal)
        } else {
            title = "Pokemon Search"
            nameTextLabel?.text = ""
            identifierTextLabel?.text = ""
            typeTextLabel?.text = ""
            abilitiesTextLabel?.text = ""
            buttonTextLabel?.setTitle("", for: .normal)
        }
    }
    
    // MARK: - Properties
    var pokemon: Pokemon? {
        return pokemonController?.pokemon
    }
    
    var pokemonController: PokemonController?

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var identifierTextLabel: UILabel!
    @IBOutlet weak var typeTextLabel: UILabel!
    @IBOutlet weak var abilitiesTextLabel: UILabel!
    @IBOutlet weak var buttonTextLabel: UIButton!
    @IBOutlet weak var imageView: UIImageView!
}
