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
<<<<<<< HEAD
            updateViews()
=======
            //TODO
>>>>>>> parent of f5d1f1e... So close to being done
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
    
<<<<<<< HEAD
    private func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemonLiteral = pokemon else {
            title = "Search Pokemon"
            return
        }
//        print("\(pokemonLiteral.name) set in detail view")
        title = pokemonLiteral.name.uppercased()
        name.text = pokemon?.name
        id.text = "ID: \(pokemonLiteral.id)"
        
        var types: [String] = []
        for typeLiteral in pokemonLiteral.types {
            types.append(typeLiteral.type.name)
        }
        type.text = "\(types.joined(separator: ","))"
        ability.text = "Ability: \(pokemonLiteral.abilities[0].ability.name)"
        
        pokemonController?.fetchImage(from: pokemonLiteral.sprites.imageUrl, completion:
            { (pokemonImage) in  // TODO
                DispatchQueue.main.async {
                    self.image.image = pokemonImage
                }
        })
    }
    
    // MARK: - ACTION
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        pokemonController?.addPokemon(pokemon: pokemon)
        //GO TO POI PROJECT TO PASS INFO FROM VC TO TV
        
        
        navigationController?.popViewController(animated: true)
        //DELETE
//        pokemonController?.fetchPokemon(name: "Eevee", completion: { result in
//            do {
//                let names = try result.get()
//                DispatchQueue.main.async {
//                    self.pokemon = names
//                }
//            } catch {
//                if let error = error as? PokemonController.NetworkError {
//                    switch error {
//                    case .incompleteData:
//                        print("Button not fully tapped")
//                    case .noData, .tryAgain:
//                        print("Have user try again")
//                    default:
//                        break
//                    }
//                }
//            }
//        }
//        )}
}
}

//TODO - EXTENSION 4 SEARCH BAR?
extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ sender: UISearchBar) {
=======
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
>>>>>>> parent of f5d1f1e... So close to being done
        guard let searchTerm = searchBar.text else { return }
        pokemonController?.fetchPokemon(name: searchTerm) { (pokemon) in
            
            guard let pokemon = try? pokemon.get() else { return }
            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
        }
<<<<<<< HEAD
        //TODO - CONFUSION 
        guard let pokemonImageURL = pokemon?.sprites.imageUrl else { return }
        pokemonController?.fetchImage(from: pokemonImageURL, completion: { (pokemonImage) in
=======
        guard let pokemonImageURL = pokemon?.sprites.imageUrl else {return}
        //TODO -- FIX
        pokemonController?.fetchImage(from: pokemonURL, completion: { (pokemonImage) in
>>>>>>> parent of f5d1f1e... So close to being done
            DispatchQueue.main.async {
                self.image.image = pokemonImage
            }
        })
    }
}

