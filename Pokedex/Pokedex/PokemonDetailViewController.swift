//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_268 on 2/14/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - Outlets
    
    override func viewDidLoad() {
           super.viewDidLoad()
           searchBar.delegate = self
           searchBar.becomeFirstResponder()
           updateViews()

           // Do any additional setup after loading the view.
       }
       
    
    @IBOutlet weak var detailNameLabel: UILabel!
    
    @IBOutlet weak var actualName: UILabel!
    @IBOutlet weak var typeNameLabel: UILabel!
    @IBOutlet weak var actualTypes: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var actualID: UILabel!
    @IBOutlet weak var actualAbilities: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var spriteView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - PROPERTIES
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    // MARK: - METHODS
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        
        if let data = pokemon.image {
            let image = UIImage(data: data)
            spriteView.image = image
        } else { pokemonController?.fetchImage(for: pokemon, completion:  { result in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.spriteView.image = image
                }
            } else {
                print(result)
                }
            })
            }
        
    actualName.text = pokemon.name.capitalized
    actualID.text = String(pokemon.id)
        actualAbilities.text = "\(pokemon.abilities[0].ability.name.capitalized)"
        actualTypes.text = "\(pokemon.types[0].type.name.capitalized)"
    
    
}
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text?.lowercased() else { return }
        pokemonController?.searchForPokemon(with: search, completion: { result in
            let pokemon = try? result.get()
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.updateViews()
            }
        })
    }
    
   
    @IBAction func savePressed(_ sender: Any) {
        guard let newPokemon = pokemon else { return }
        pokemonController?.pokemons.append(newPokemon)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



}
