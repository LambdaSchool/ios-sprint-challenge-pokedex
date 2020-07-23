//
//  pokemonTableViewController.swift
//  Pokedex2
//
//  Created by Clean Mac on 7/20/20.
//  Copyright © 2020 LambdaStudent. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    let reuseIdentifier = "PokemonCell"
    private var pokemonNameList: [Pokemon] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    let pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        pokemonNameList = pokemonController.savedPokemon
    }
    
    // TABLE VIEW DATA
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.savedPokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = pokemonController.savedPokemon[indexPath.row]
        cell.textLabel?.text = pokemon.name.capitalized
        return cell
        
        
    // SEGUE NAVIGATION 
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue"{
            if let detailVC = segue.destination as? PokemonDetailViewController {
                detailVC.pokemonController = pokemonController
            if let indexPath = tableView.indexPathForSelectedRow {
                detailVC.pokemon = pokemonController.savedPokemon[indexPath.row]
            }
        }
        }
        else if segue.identifier == "SearchPokemonSegue" {
            // inject dependencies
            if let searchPokemonVC = segue.destination as? PokemonDetailViewController {
                searchPokemonVC.pokemonController = pokemonController
            }
        }
    }
    
  
    
    

}
