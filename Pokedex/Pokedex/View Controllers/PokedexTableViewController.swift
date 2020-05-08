//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Dahna on 5/8/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    let pokemonController = PokemonController()
    let reuseIdentifier = "PokeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokeList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        let pokemon = pokemonController.pokeList[indexPath.row]
        cell.textLabel?.text = pokemon.name.capitalized
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.deletePokemon(index: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchPokeSegue" {
            guard let destinationVC = segue.destination as? SearchPokemonViewController else { return }
            destinationVC.pokemonController = pokemonController
        }
        
        if segue.identifier == "ShowPokeSegue" {
            if let destinationVC = segue.destination as? DetailPokemonViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.pokemonController = pokemonController
                destinationVC.pokemon = pokemonController.pokeList[indexPath.row]
                
            }
            
        }
        
    }
    
    
}
