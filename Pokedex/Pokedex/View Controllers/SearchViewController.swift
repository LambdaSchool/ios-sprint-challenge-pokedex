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
    
   
    
    private func updateViews() {
        
        guard let pokemon = pokemon else {
            title = "Pokemon Search"
            pokemonTitleLabel.text = nil
            typesLabel.text = nil
            abilitiesLabel.text = nil
            idLabel.text = nil
            
            return
        }
        
        title = pokemon.name.capitalized
        pokemonTitleLabel.text = pokemon.name.capitalized
        idLabel.text = "\(pokemon.id)"
        let types = pokemon.types.map { $0.type.name }.joined(separator: ", ")
        typesLabel.text = "\(types)"
        let abilities = pokemon.abilities.map { $0.ability.name }.joined(separator: ", ")
        abilitiesLabel.text = "\(abilities)"
        pokemonController?.fetchImage(at: pokemon.sprites.front_default, completion: { (result) in
           
            do {
                let result = try result.get()
                DispatchQueue.main.async {
                    self.pokemonImageView.image = result
                }
                
            } catch {
                print("Error getting image: \(error)")
            }
            
        })
        
        
        
        
    }

    
    
    @IBAction func savePokemonButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon, let pokemonController = pokemonController else { return }
        
        pokemonController.savePokemon(with: pokemon)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}


extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonController = pokemonController, let searchTerm = searchBar.text else { return }
        
        pokemonController.searchForPokemon(with: searchTerm.lowercased()) { (result) in
            DispatchQueue.main.async {
                do {
                    let result = try result.get()
                    self.pokemon = result
                    self.updateViews()
                    
                } catch {
                    print("Error getting result: \(error)")
                }
            }
        }
    }
}
