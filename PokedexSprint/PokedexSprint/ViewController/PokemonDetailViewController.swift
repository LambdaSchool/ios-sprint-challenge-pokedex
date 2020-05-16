//
//  PokemonDetailViewController.swift
//  PokedexSprint
//
//  Created by Clayton Watkins on 5/15/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonSpriteImage: UIImageView!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAbilityLabel: UILabel!
    @IBOutlet weak var addPokemonButton: UIButton!
    
    //MARK: - Properties
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        pokemonSearchBar.delegate = self
    }
    
    //MARK: - IBActions
    //Appends pokemon to our array of pokemon
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else{ return }
        pokemonController?.savePokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - HelperFunctions
    //Function to help us update our view appropriately if we have a pokemon on display or not
    private func updateViews(){
        if let pokemon = pokemon{
            pokemonNameLabel.text = pokemon.name.capitalizingFirstLetter()
            pokemonIdLabel.text = "ID: \(String(pokemon.id))"
            pokemonTypeLabel.text = "Types: \(pokemon.types.joined(separator: " , ").capitalizingFirstLetter())"
            pokemonAbilityLabel.text = "Ability: \(pokemon.ability.joined(separator: " , ").capitalizingFirstLetter())"
            self.pokemonController?.getSprite(at: pokemon.sprites, completion: { (result) in
                if let image = try? result.get(){
                    DispatchQueue.main.async {
                        self.pokemonSpriteImage.image = image
                    }
                }
            })
        } else {
            pokemonNameLabel.text = ""
            pokemonIdLabel.text = ""
            pokemonTypeLabel.text = ""
            pokemonAbilityLabel.text = ""
        }
    }
    
    //Function to hide elements of our UI But I can't figure out when to implement it for it to work
    func hideUI(){
        self.pokemonSearchBar.isHidden = true
        self.addPokemonButton.isHidden = true
    }
}

extension PokemonDetailViewController: UISearchBarDelegate{
    //Displays decoded information and puts it on the main queue to be displayed
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonName = pokemonSearchBar.text else { return }
        pokemonController?.searchForPokemon(searchTerm: pokemonName, completion: { (result) in
            let pokemon = try? result.get()
            if let pokemon = pokemon{
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews()
                }
                //Loading Pokemon Image
                self.pokemonController?.getSprite(at: pokemon.sprites, completion: { (result) in
                    if let image = try? result.get(){
                        DispatchQueue.main.async {
                            self.pokemonSpriteImage.image = image
                        }
                    }
                })
            }
        })
    }
}

//Function on class string to help us keep things clean and capitialize the first letter of our strings
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
