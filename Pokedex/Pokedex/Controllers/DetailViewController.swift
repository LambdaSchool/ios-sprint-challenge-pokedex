//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Sameera Leola on 12/21/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    
    @IBOutlet weak var allElementsStack: UIStackView!
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var spriteImage: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonSearchBar.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func pokemonSave(_ sender: Any) {
        PersistentData.shared.add(pokemon: self.pokemon!)
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        pokemonSearchBar.autocapitalizationType = .none
        pokemonSearchBar.resignFirstResponder()
        guard let findThisPokemon = pokemonSearchBar.text?.lowercased(), !findThisPokemon.isEmpty else { return }
        
        // Clear the searchbar and set the placeholder text
        searchBar.text = ""
        searchBar.placeholder = findThisPokemon.lowercased()
        
        NetworkData.shared.searchForPokemon(with: findThisPokemon) { (error) in
            if error == nil {
               
                DispatchQueue.main.async {
                    // First, make sure we have a Pokemon
                    guard let pokemon = NetworkData.shared.pokemonAPI else { return }
                    // We have a Pokemon so populate the fields
                    self.pokemonNameLabel.text = pokemon.name
                    self.pokemonIDLabel.text = "\(pokemon.id)"
                    let pokemonTypes = pokemon.types.map({$0.type.name.capitalized}).joined(separator: ", ")
                    self.pokemonTypeLabel.text = pokemonTypes
                    let pokemonAbilities = pokemon.abilities.map({$0.ability.name.capitalized}).joined(separator: ", ")
                    self.pokemonAbilitiesLabel.text = pokemonAbilities
                    //get the sprite
                    guard let url = URL(string: pokemon.sprites.frontDefault), let spriteData = try? Data(contentsOf: url) else { return }
                    self.spriteImage.image = UIImage(data: spriteData)
                    
                    //Show the form if necessary
                    if (self.allElementsStack.isHidden == true) {
                        self.allElementsStack.isHidden.toggle()
                    }
                    // Clear the placeholder text
                    searchBar.placeholder = nil
                    self.navigationItem.title = pokemon.name
                    self.saveButton.setTitle("Save \(pokemon.name?.capitalized ?? "Pokemon")", for: .normal)
                    self.pokemon = Pokemon.init(name: pokemon.name!, id: "\(pokemon.id)", abilities: pokemonAbilities, types: pokemonTypes, sprite: self.spriteImage.image!)
                    
                }
            }
        }
    }

} // End of class
