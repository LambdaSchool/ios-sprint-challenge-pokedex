//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by macbook on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    var apiController = APIController()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiController.pokemonList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Pokemon Cell", for: indexPath)
        
        cell.textLabel?.text = apiController.pokemonList[indexPath.row].name

        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchNewPokemonSegue" {
            if let pokemonDetailVC = segue.destination as? PokedexDetailViewController {
                pokemonDetailVC.apiController = apiController
            }
        } else if segue.identifier == "PokemonDetailVCSegue" {
            if let pokemonDeatilVC = segue.destination as? PokedexDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                pokemonDeatilVC.apiController = apiController
                pokemonDeatilVC.pokemon = apiController.pokemonList[indexPath.row]
            }
        }
    }
}
