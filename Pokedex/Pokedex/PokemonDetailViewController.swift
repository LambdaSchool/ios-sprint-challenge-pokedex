//
//  PokemonDetailViewContorller.swift
//  Pokedex
//
//  Created by Gladymir Philippe on 7/17/20.
//  Copyright © 2020 Gladymir Philippe. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemonController = PokemonController()
    var pokemon: Pokemon!
    
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
//        updateViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        guard let pokemon = pokemon else {
            print("Pokemon does not exist!")
            return
            
        }
        

            pokemonController.savePokemon(pokemon: pokemon)
            navigationController?.popViewController(animated: true)
            print("Pokemon Count: \(pokemonController.savedPokemon.count)")
        
    }
    
    func updateViews() {
        guard let pokemon = pokemon else {
            title = "Pokemon Search"
            return
        }
    
        
        DispatchQueue.main.async {
            self.title = self.pokemon.name.capitalized
            self.nameLabel.text = self.pokemon.name.capitalized
            self.idLabel.text = "ID: \(self.pokemon.id)"
            self.typesLabel.text = "Types: \(self.pokemon.types.joined(separator: ", "))"
            self.abilitiesLabel.text = "Abilities: \(self.pokemon.ability.joined(separator: ", "))"
        }
        
        
        self.pokemonController.fetchSprite(at: pokemon.sprites, completion: { (result) in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        })
        
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
        
        pokemonController.fetchPokemon(with: pokemonName, completion: { result in
            switch result {
              case .success(let pokemon):
                
                self.pokemon = pokemon
                
                self.updateViews()
                
                self.pokemonController.savePokemon(pokemon: pokemon)
              case .failure(let error):
                print(error.localizedDescription)
            }
          })
        }
    }
