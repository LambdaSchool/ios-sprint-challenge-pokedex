//
//  PokedexTableViewController.swift
//  SprintChallenge-Pokedex
//
//  Created by Ciara Beitel on 9/6/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    let apiController = APIController()
    
    var pokemons: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath)

        cell.textLabel?.text = pokemons[indexPath.row].pokemon.name
        
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonSearchShowSegue" {
            if let searchVC = segue.destination as? PokemonSearchViewController {
                searchVC.apiController = apiController
            }
        } else if segue.identifier == "PokemonDetailShowSegue" {
            
            if let detailVC = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                
                detailVC.apiController = apiController
                detailVC.title = self.pokemons[indexPath.row].pokemon.name
            }
        }
    }
}




