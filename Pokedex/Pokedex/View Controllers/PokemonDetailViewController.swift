//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Cameron Dunn on 1/25/19.
//  Copyright © 2019 Cameron Dunn. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var searchedPokemon : Pokemon?
    var model : Model = Model()
    var pokemon : Pokemon?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateViews()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        model.pokemonSearch(term: searchBar.text!) { (resultPokemon, error) in
            DispatchQueue.main.async {
                self.pokemon = resultPokemon
                self.updateViews()
            }
        }
    }
    func updateViews(){
        guard let currentPokemon = pokemon else{
            self.nameLabel.text = "No Pokémon found."
            self.abilitiesLabel.isHidden = true
            self.typeLabel.isHidden = true
            self.idLabel.isHidden = true
            self.button.isHidden = true
            return
        }
        self.searchedPokemon = currentPokemon
        print("\((pokemon?.types[0].type)!)")
        self.abilitiesLabel.isHidden = false
        self.button.isHidden = false
        self.typeLabel.isHidden = false
        self.idLabel.isHidden = false
        self.title = "\(currentPokemon.name)"
        self.idLabel.text = "ID: \(currentPokemon.identifier)"
        self.nameLabel.text = currentPokemon.name
        var types : String = ""
        for index in currentPokemon.types{
            if(index == currentPokemon.types[0]){
                types.append("Type: \(index.type.name)")
            }else{
                types.append(", \(index.type.name)")
            }
        }
        var abilities : String = ""
        self.typeLabel.text = types
        for index in currentPokemon.abilities{
            if(index == currentPokemon.abilities[0]){
                abilities.append("Abilities: \(index.ability.name)")
            }else{
                abilities.append(", \(index.ability.name)")
            }
        }
        self.abilitiesLabel.text = abilities
    }
    @IBAction func SaveButtonTapped(_ sender: UIButton) {
        model.savedPokemon.append(searchedPokemon!)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! PokemonTableViewController
        destination.model = self.model
    }
    
}
