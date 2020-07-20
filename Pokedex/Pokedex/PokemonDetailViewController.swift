//
//  PokemonDetailViewContorller.swift
//  Pokedex
//
//  Created by Gladymir Philippe on 7/17/20.
//  Copyright © 2020 Gladymir Philippe. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        updateViews()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if let pokemonController = pokemonController,
            let pokemon = pokemon {
            pokemonController.savePokemon(pokemon: pokemon)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func updateViews() {
        guard let pokemon = pokemon else {
            title = "Pokemon Search"
            return
        }
    
        
        title = pokemon.name.capitalized
        idLabel.text = "ID: \(pokemon.id)"
        typesLabel.text = "Types: \(pokemon.types.joined(separator: ", "))"
        abilitiesLabel.text = "Abilities: \(pokemon.ability.joined(separator: ", "))"
        self.pokemonController?.fetchSprite(at: pokemon.sprites, completion: { (result) in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        })
        
        func hideUI() {
            idLabel.isHidden = true
            typesLabel.isHidden = true
            abilitiesLabel.isHidden = true
            saveButton.isHidden = true
        }
        
        hideUI()
        
        func showUI() {
            idLabel.isHidden = false
            typesLabel.isHidden = false
            abilitiesLabel.isHidden = false
            saveButton.isHidden = false
        }
        
        showUI()
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    }

}
extension PokemonDetailViewController: UISearchBarDelegate {

     func searchBarSearchButtonClicked(_ sender: UISearchBar) {
        guard let pokemonName = searchBar.text else { return }
        pokemonController?.fetchPokemon(with: pokemonName, completion: { (result) in
            let pokemon = try? result.get()
            if let pokemon = pokemon {
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews()
                    }
                }
            })
        }
    }
