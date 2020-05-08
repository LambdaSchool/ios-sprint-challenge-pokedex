//
//  DetailTableViewController.swift
//  Pokedex
//
//  Created by Marissa Gonzales on 5/8/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit

class DetailTableViewController: UIViewController {

    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButtonOutlet: UIButton!

    var pokemonController: PokemonResultsController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
  
    }
    
    func updateViews() {
         guard let pokemon = pokemon else {
             title = "Pokemon Search"
             hideImageView()
             return
         }

         showImageView()
         searchBar.isHidden = true
         pokemonNameLabel.text = pokemon.name.capitalized
         guard let imageData = try? Data(contentsOf: pokemon.sprites.defaultImageURL) else { fatalError() }
         imageView.image = UIImage(data: imageData)
         idLabel.text = "ID: \(pokemon.id)"

         var typesText: [String] = []
         var abilitiesText: [String] = []

         for pokemonType in pokemon.types {
             typesText.append(pokemonType.type.name)
         }
         for pokemonAbility in pokemon.abilities {
             abilitiesText.append(pokemonAbility.ability.name)
         }

        typeLabel.text = "Types: \(typesText.joined(separator: ", ").capitalized)"
        abilitiesLabel.text = "Abilities: \(abilitiesText.joined(separator: ", ").capitalized)"

     }
    
    func hideImageView() {
        
    }
    
    func showImageView() {
        
    }

    @IBAction func saveButtonFunc(_ sender: Any) {
  
    }
}
extension DetailTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonName = searchBar.text else { return }
        pokemonController?.getPokemon(with: pokemonName, completion: { (result) in
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
