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
    
    var pokemonController: PokemonController?
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
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
        searchBar.delegate = self
        updateViews()
        // TODO
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemonLiteral = pokemon else {
            title = "Pokemon"
            return
        }
        print("\(pokemonLiteral.name) set in detail view")
        title = pokemonLiteral.name.capitalized
        name.text = pokemon?.name
        id.text = "ID: \(pokemonLiteral.id)"
        
        var types: [String] = []
        for typeLiteral in pokemonLiteral.types {
            types.append(typeLiteral.type.name)
        }
        type.text = "\(types.joined(separator: ","))"
        ability.text = "\(pokemonLiteral.abilities[0].ability.name)"
        
        pokemonController?.fetchImage(from: pokemonLiteral.sprites.imageUrl, completion:
            { (pokemonLiteral) in  // TODO
                DispatchQueue.main.async {
                    self.image.image = pokemonLiteral
                }
        })
    }
    
    
    // MARK: - ACTION
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        pokemonController?.fetchPokemon(name: "Test", completion: { result in
            do {
                let names = try result.get()
                DispatchQueue.main.async {
                    self.pokemon = names
                }
            } catch {
                if let error = error as? PokemonController.NetworkError {
                    switch error {
                    case .incompleteData:
                        print("Button not fully tapped")
                    case .noData, .tryAgain:
                        print("Have user try again")
                    default:
                        break
                    }
                }
            }
        }
        )}
}

//TODO - EXTENSION 4 SEARCH BAR?
extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ sender: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        pokemonController?.fetchPokemon(name: searchTerm) { (pokemonLiteral) in
            
            guard let pokemon = try? pokemonLiteral.get() else { return }
            
            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
        }
        //TODO - CONFUSION 
        guard let pokemonImageType = pokemon?.sprites.imageUrl else { return }
        pokemonController?.fetchImage(from: pokemonImageType, completion: { (pokemonImage) in
            DispatchQueue.main.async {
                self.image.image = pokemonImage
            }
        })
    }
}

