//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Bobby Keffury on 9/14/19.
//  Copyright © 2019 Bobby Keffury. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonTitleLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController: PokemonController?
    var pokemonTableViewController = PokemonTableViewController()
    var pokemon: Pokemon?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
        searchBar.delegate = self
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
//    private func getPokemon() {
//        guard let pokemonController = pokemonController, let pokemon = pokemon else {
//            return
//        }
//
//        pokemonController.searchForPokemon(with: pokemon) { (result) in
//            do {
//                let pokemon = try result.get()
//                DispatchQueue.main.async {
//                    self.updateViews(with: pokemon)
//                }
//
//                pokemonController.fetchImage(at: pokemon.sprites, completion: { (result) in
//                    if let image = try? result.get() {
//                        DispatchQueue.main.async {
//                            self.pokemonImageView.image = image
//                        }
//                    }
//                })
//
//            } catch let error as NetworkError {
//                switch error {
//                case .badData:
//                    print("Bad Data")
//                default:
//                    print("error")
//                }
//            } catch {
//                print(error)
//            }
//        }
//
//
//    }
    
    private func updateViews() {
        
        guard let pokemon = pokemon else {
            title = "Pokemon Search"
            pokemonTitleLabel.text = nil
            typesLabel.text = nil
            abilitiesLabel.text = nil
            idLabel.text = nil
            
            return
        }
        
        title = pokemon.name
        pokemonTitleLabel.text = pokemon.name
        idLabel.text = "\(pokemon.id)"
        typesLabel.text = "\(pokemon.types)"
        abilitiesLabel.text = "\(pokemon.abilities)"
        
    }

    
    
    @IBAction func savePokemonButtonTapped(_ sender: Any) {
        // Need to get the pokemon information from the pokemon that was searched for.
        
       // pokemonTableViewController.pokemon.append(insert pokemon from above)
    }
    
}


extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonController = pokemonController, let searchTerm = searchBar.text else { return }
        
        pokemonController.searchForPokemon(with: searchTerm) { (result) in
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
        
    }
}
