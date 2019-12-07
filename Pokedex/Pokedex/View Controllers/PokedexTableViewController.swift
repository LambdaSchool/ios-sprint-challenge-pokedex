//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Zack Larsen on 12/6/19.
//  Copyright © 2019 Zack Larsen. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    private var pokemonNames: [Pokemon] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    let pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath)
        let pokemon = pokemonController.pokemons[indexPath.row]
        //        cell.textLabel?.text = pokemon.name
        //
                return cell
            }
        
        
        
        // MARK: - Navigation
        
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showPokeDetail" {
                if let detailVC = segue.destination as?
                    PokemonDetailViewController {
                    if let indexPath =
                        tableView.indexPathForSelectedRow {
                        detailVC.pokemon =
                            pokemonNames[indexPath.row]
                        
                    } else if segue.identifier == "Pokedex" {
                        guard let destination = segue.destination as? PokemonDetailViewController
                            else { return }
                        destination.pokemonController = pokemonController
                    }
                    
                }
            }
        
}
}
