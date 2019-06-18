//
//  PokemonSearchViewController.swift
//  Pokedex (Sprint)
//
//  Created by Nathan Hedgeman on 6/15/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    
    
    
    //Properties
    var pokemonControllerSVC: PokemonController?
    
    let segueID = "PokemonSearchSegue"
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self

        // Do any additional setup after loading the view.
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemonControllerSVC = pokemonControllerSVC else {return}
        pokemonControllerSVC.savePokemon()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueID {
            let tableVC = segue.destination as? PokedexTableViewController
            tableVC!.pokemonControllerTVC = pokemonControllerSVC!
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    func updateVIews(pokemon: Pokemon) {
        pokemonNameLabel.text = pokemon.name
        let pokeID = "\(pokemon.id)"
        idLabel.text = pokeID
        abilitiesLabel.text = pokemon.abilities.ability.name
        typeLabel.text = pokemon.type.type.name
        
    }
    
    func getPokemon() {
        
        
        
    }
    

}
