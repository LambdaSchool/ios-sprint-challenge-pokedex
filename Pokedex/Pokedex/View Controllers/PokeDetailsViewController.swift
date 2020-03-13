//
//  PokeDetailsViewController.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_259 on 3/13/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import UIKit

class PokeDetailsViewController: UIViewController {
    
    // MARK: - Properties
    var pokeController: PokeController?
    var pokemon: Pokemon?
    
    
    // MARK: - IBOutlets
    @IBOutlet var pokeImageView: UIImageView!
    @IBOutlet var pokeIDLabel: UILabel!
    @IBOutlet var pokeTypesLabel: UILabel!
    @IBOutlet var pokeAbilitiesLabel: UILabel!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var searchBar: UISearchBar!
    
    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let pokemon = pokemon else {
            navigationController?.popToRootViewController(animated: true)
            return
        }
        pokeController?.pokemons.append(pokemon)
        navigationController?.popToRootViewController(animated: true)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateViews()
    }
    
    func updateViews() {
        if let pokemon = pokemon {
            title = pokemon.name.capitalized
            pokeIDLabel.text = "ID: \(pokemon.id)"
            
            var typesText: String = "\(pokemon.types[0].type.name.capitalized)"
            if pokemon.types.count > 1 {
                for i in 1..<pokemon.types.count {
                    typesText.append(", \(pokemon.types[i].type.name.capitalized)")
                }
            }
            pokeTypesLabel.text = "Types: \(typesText)"
            
            var abilitiesText: String = "\(pokemon.abilities[0].ability.name.capitalized)"
            if pokemon.abilities.count > 1 {
                for i in 1..<pokemon.abilities.count {
                    abilitiesText.append(", \(pokemon.abilities[i].ability.name.capitalized)")
                }
            }
            pokeAbilitiesLabel.text = "Abilities: \(abilitiesText)"
            
            guard let imageURL = URL(string: pokemon.sprites.frontDefault) else { return }
            pokeImageView.load(url: imageURL)
        } else {
            title = "Search Pokemon"
        }
    }

}

extension PokeDetailsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let pokemon = searchBar.text,
            !pokemon.isEmpty {
            pokeController?.fetchPokemon(pokemon: pokemon) { result in
                if let pokemon = try? result.get() {
                    DispatchQueue.main.async {
                        self.pokemon = pokemon
                        self.updateViews()
                    }
                } 
            }
            
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
