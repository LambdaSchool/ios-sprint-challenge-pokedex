//
//  PokedexSearchViewController.swift
//  Pokedex
//
//  Created by Gerardo Hernandez on 1/27/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import UIKit

class PokedexSearchViewController: UIViewController {

     // MARK: - Properties

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!

    

    
    
        
    var pokedexController = PokedexController()
        var pokemon: Pokemon? {
            didSet {
             updateViews()
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
               
            idLabel.isHidden = true
            nameLabel.isHidden = true
            typesLabel.isHidden = true
            abilitiesLabel.isHidden = true
            searchBar.becomeFirstResponder()
            searchBar.delegate = self
           
        }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
            guard let pokemon = pokemon else { return }
    //        pokedexController.pokemons.append(pokemon)
            pokedexController.savePokemon(pokemon: pokemon)
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
            print("\(pokemon.name)")
            
        }
        
        
            private func updateViews() {
            guard let pokemon = pokemon else { return }
            
            DispatchQueue.main.async {
                self.idLabel.isHidden = false
                self.nameLabel.isHidden = false
                self.typesLabel.isHidden = false
                self.abilitiesLabel.isHidden = false
                self.nameLabel.text = "\(pokemon.name.capitalized)"
                self.idLabel.text = "\(pokemon.id)"
                self.typesLabel.text = pokemon.types[0].type.name
                self.abilitiesLabel.text = pokemon.abilities[0].ability.name
                
            }
        }
        
        
    }
    extension PokedexSearchViewController: UISearchBarDelegate {
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            guard let searchText = searchBar.text else {return}
            
            pokedexController.pokemonSearch(searchTerm: searchText, completion: { (result) in
               
                guard let result = try? result.get() else {return}
                
                DispatchQueue.main.async {
                    self.pokemon = result
                    self.pokedexController.fetchImage(at: (self.pokemon?.sprites.front_shiny)!, completion: { result in
                        
                        if let image = try? result.get() {
                            
                            DispatchQueue.main.async {
                                self.imageView.image = image
                            }
                            
                        }
                    })
                }
            })
        }
    }
