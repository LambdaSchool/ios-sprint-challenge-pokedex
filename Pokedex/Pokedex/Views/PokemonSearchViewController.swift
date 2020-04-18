//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Dillon P on 9/14/19.
//  Copyright © 2019 Lambda iOSPT2. All rights reserved.
//

import UIKit

protocol UpdatePokedex {
    func saveToPokedex(with pokemon: Pokemon)
}

class PokemonSearchViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var savePokemonButton: UIButton!
    
    //MARK: - Variables
    
    let pokemonSearchController = PokemonController()
    var delegate: UpdatePokedex?
    var pokemon: Pokemon?
    var elementsVisible: Bool = true

    
    // MARK: - Actions
    
    
    @IBAction func savePokemonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        delegate?.saveToPokedex(with: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        pokemonSearchBar.delegate = self
        updateViews()
        
        super.viewDidLoad()
    }
    
    private func updateViews() {
        
        if let pokemon = pokemon {
            if elementsVisible == false {
                savePokemonButton.isHidden = true
                pokemonSearchBar.isHidden = true
            }
            fetchImage()
            var abilityCount = 0
            var abilities = ""
            for _ in pokemon.abilities {
                abilities += "\(pokemon.abilities[abilityCount].ability.name.capitalized). "
                abilityCount += 1
            }
            pokemonAbilitiesLabel.text = "Abilities: \(abilities)"
            
            var typeCount = 0
            var types = ""
            for _ in pokemon.types {
                types += "\(pokemon.types[typeCount].type.name.capitalized). "
                typeCount += 1
            }
            pokemonTypeLabel.text = "Types: \(types)"
            pokemonIdLabel.text = "ID: \(pokemon.id)"
            pokemonName.text = pokemon.name.capitalized
            savePokemonButton.setTitle("Save Pokemon", for: .normal)
        } else {
            pokemonName.text = ""
            pokemonIdLabel.text = ""
            pokemonTypeLabel.text = ""
            pokemonAbilitiesLabel.text = ""
            savePokemonButton.setTitle("", for: .normal)
        }
    }
    
    private func fetchImage() {
        if let pokemon = pokemon {
        let imageURL = URL(string: pokemon.sprites.front_default)!
            pokemonSearchController.fetchImage(with: imageURL) { (data, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                if let data = data {
                    DispatchQueue.main.async {
                        self.pokemonImage.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
//    private func getImage() {
//        if let pokemon = pokemon {
//            pokemonSearchController.getImage(for: pokemon.id) { (result) in
//                if let imageData = try? result.get() {
//                    print(imageData)
//                    if let imagePNG = UIImage(data: imageData)?.pngData() {
//                        let image = UIImage(data: imagePNG)
//                        DispatchQueue.main.async {
//                            self.pokemonImage.image = image
//                        }
//                    } else {
//                        print("no image")
//                    }
//                }
//            }
//        }
//    }
}

// MARK: - Extensions

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        let pokemonName = searchTerm.lowercased()
        
        pokemonSearchController.searchForPokemon(with: pokemonName) { (result) in
            do {
                let pokemonObject = try result.get()
                self.pokemon = pokemonObject
                DispatchQueue.main.async {
                    self.updateViews()
                }
            } catch {
                print("Error setting pokemon object: \(error)")
            }
        }
    }
}

