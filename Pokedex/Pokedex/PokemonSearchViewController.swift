//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Moin Uddin on 9/14/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        nameLabel.text = pokemon.name
        idLabel.text = "id: " + String(pokemon.id)
        typesLabel.text = "types: " + typesToString(types: pokemon.types)
        abilitiesLabel.text = "abilties: " + abilitiesToString(abilities: pokemon.abilities)
        savePokemonButton.setTitle("Save", for: .normal)
    }
    
    func typesToString(types: [Pokemon.PokemonType]) -> String {
        var str = ""
        for pokemonType in types {
            str += " \(pokemonType.type.name),"
        }
        return str
    }
    
    func abilitiesToString(abilities: [Pokemon.PokemonAbility]) -> String {
        var str = ""
        for pokemonAbility in abilities {
            str += " \(pokemonAbility.ability.name),"
        }
        return str
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        pokemonController?.fetchPokemon(nameOrId: searchTerm.lowercased(), completion: { (_, pokemon) in
            self.pokemon = pokemon
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func savePokemon(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokemonController?.createPokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var savePokemonButton: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }

        }
    }
    
    var pokemonController: PokemonController?
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
