//
//  PokemonTableViewController.swift
//  FlexPokemonSprint
//
//  Created by admin on 10/4/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    var pokemonController = PokemonController()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonController.loadFromPersistentStore()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pokemonController.loadFromPersistentStore()
        //tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonTableViewCell else { return UITableViewCell() }
        
        cell.pokemon = pokemonController.pokemons[indexPath.row]

        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            guard let destinationVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.pokemonController = pokemonController
            destinationVC.pokemon = pokemonController.pokemons[indexPath.row]
        } else if segue.identifier == "SearchSegue" {
            guard let destinationVc = segue.destination as? SearchViewController else { return }
            destinationVc.pokemonController = pokemonController
        }
    }
    

}
