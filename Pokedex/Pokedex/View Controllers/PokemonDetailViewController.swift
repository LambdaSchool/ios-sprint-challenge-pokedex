//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Zack Larsen on 12/6/19.
//  Copyright © 2019 Zack Larsen. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var IdLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    var abilities: Abilities?
    var ability: Ability?
    var types: Types?
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        
        
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchResult = searchBar.text?.lowercased() else {
//             let pokemonController = pokemonController else {
            print("You didn't enter a Pokemon.")
            return
            
        }
        print(searchResult)
        pokemonController?.fetchDetails(for: searchResult, completion: { (result) in
            guard let pokemon = try? result.get() else {
                print("Did not find a pokemon")
                return
            }
            print(pokemon)
        })
        //        pokemonController.fetchDetails(for: searchResult) { (result) in
        //            do {
        //                guard let pokemon = self.pokemon else { return }
        //                var temp = pokemon
        //                temp = try result.get()
        //                DispatchQueue.main.async {
        //                    self.updateViews(with: pokemon)
        //                }
        //            } catch {
        //                //                if let error = error {
        //                ////                    print("Error fetching pokemon")
        //                ////                }
        //                ////
        //            }
        //
        //        }
        //
    }
    
    private func updateViews(with pokemon: Pokemon, with ability: Ability, with abilities: Abilities, with types: Types) {
        title = pokemon.name
        displayName.text = pokemon.name
//        IdLabel.text = pokemon.id
        typesLabel.text = types.nameType
        abilitiesLabel.text = ability.nameAbility
        //        pokemonImage.
        
    }
    
    
    
    // Do any additional setup after loading the view.
    
    
    @IBAction func savePokemonTapped(_ sender: UIButton) {
        guard let title = displayName.text,
            let idLabel = IdLabel.text else { return }
        
        //        pokemonController?.fetchDetails(for: pokemonName, completion: { result  in
        //            DispatchQueue.main.async {
        //                self.navigationController?.popViewController(animated: true)
        //            }
        //        }
        //
        //    })
        //
        
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
}
