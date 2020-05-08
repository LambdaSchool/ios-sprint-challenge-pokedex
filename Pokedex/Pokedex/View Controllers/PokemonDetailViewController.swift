//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Nonye on 5/8/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

import UIKit
import Foundation

class PokemonDetailViewController: UIViewController {
    
    var pokemonController: PokemonController? {
        didSet {
            //TODO
        }
    }
    
    var pokemon: Pokemon? {
        didSet {
            //TODO
        }
    }
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var type: UILabel!
    
    @IBOutlet weak var ability: UITextView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO
    }
    
    // MARK: - ACTION
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        //TODO
        //pokemonController?.(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    func getDetails() {
        guard let pokemon = pokemon else {
            //TODO - figure out what to input
            pokemonController?.fetchPokemon(name: name, completion: { result in
                if let animals = try? result.get() {
                    DispatchQueue.main.async {
                        self.updateViews(with: animals)
                    }
                    self.apiController?.fetchImage(at: animals.imageURL, completion: { result in
                        if let image = try? result.get() {
                            DispatchQueue.main.async {
                                self.animalImageView.image = image
                            }
                        }
                    })
                }
            })
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    //TODO - EXTENSION 4 SEARCH BAR?
    func searchBarsearchButtonTapped(_ sender: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        pokemonController?.fetchPokemon(name: searchTerm) { (pokemon) in
            
            guard let pokemon = try? pokemon.get() else { return }
            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
        }
        guard let pokemonImageURL = pokemon?.sprites.imageUrl else {return}
        //TODO -- FIX
        pokemonController?.fetchImage(from: pokemonURL, completion: { (pokemonImage) in
            DispatchQueue.main.async {
                self.image.image = pokemonImage
            }
        })
    }
}

