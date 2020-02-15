//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Keri Levesque on 2/14/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import UIKit
protocol PokemonDetailVCDelegate: AnyObject {
    func didReceivePokemon(pokemon: Pokemon)
}
class PokemonDetailViewController: UIViewController {
    //MARK: Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
     @IBOutlet weak var searchBar: UISearchBar! {
           didSet {
               searchBar.becomeFirstResponder()
               searchBar.delegate = self
           }
       }
       @IBOutlet weak var saveButton: UIButton!
       weak var delegate: PokemonDetailVCDelegate?
       
       //MARK: Properties
       var pokemonController: PokemonController!
       var pokedexTableViewController: PokedexTableViewController!
       
       var pokemon: Pokemon?
       
       //MARK: Life Cycle
       
       override func viewDidLoad() {
           super.viewDidLoad()
       }
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           updateViews()
       }
      //MARK: Methods

       func updateViews() {
           if let pokemon = pokemon  {
               guard let imageData = try? Data(contentsOf: URL(string: pokemon.sprites!.frontDefault)!) else { return }
                guard let name = pokemon.name else { return }
                        nameLabel.text = name
              
                       idLabel.text = "ID: \(String(describing: pokemon.id!))"
                       pokeImage.image = UIImage(data: imageData)
                      
                       
                       var abilities: [String] = []
                       var types: [String] = []
                       
                       for newType in pokemon.types {
                           types.append(newType.type.name)
                       }

                       for newAbility in pokemon.abilities {
                           abilities.append(newAbility.ability.name)
                       }
                       
                       typesLabel.text = "Type: \(types.last!)"
                       abilitiesLabel.text = "Ability: \(abilities.last!)"
            }
        }

       //MARK: Actions
       
       @IBAction func saveButton(_ sender: UIButton) {
           let pokemon = Pokemon(name: pokemonController.pokemons?.name, id: pokemonController.pokemons?.id, abilities: pokemonController.pokemons!.abilities, types: pokemonController.pokemons!.types, sprites: pokemonController.pokemons?.sprites)
           
           delegate?.didReceivePokemon(pokemon: pokemon)

           navigationController?.popViewController(animated: true)
        
    }
}
   extension PokemonDetailViewController: UISearchBarDelegate {
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           guard let searchTerm = searchBar.text?.lowercased() else { return }
          
           pokemonController.fetchPokemon(for: searchTerm) { result in
               let pokemon = try? result.get()
                               
               DispatchQueue.main.async {
                   self.pokemon = pokemon
                   self.updateViews()
               }
           }
       }
   }

