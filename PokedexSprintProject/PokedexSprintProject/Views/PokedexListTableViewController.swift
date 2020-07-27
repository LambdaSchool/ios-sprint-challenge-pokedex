//
//  PokedexListTableViewController.swift
//  PokedexSprintProject
//
//  Created by BrysonSaclausa on 7/18/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import UIKit

class PokedexListTableViewController: UITableViewController {
    
    let pokemonController = PokemonController()
    
    var pokemons: [Pokemon] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        pokemons = pokemonController.pokemonResults
    }

    
    
    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return pokemonController.pokemonResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath)
        let pokemon = pokemonController.pokemonResults[indexPath.row]
        cell.textLabel?.text = pokemon.name.capitalized
        return cell
    }

  
    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showDetailSegue" {
                if let detailVC = segue.destination as? SearchDetailViewController {
                    detailVC.pokemonController = pokemonController
                    if let indexPath = tableView.indexPathForSelectedRow {
                        detailVC.pokemon = pokemonController.pokemonResults[indexPath.row]
                    }
                }
            } else if segue.identifier == "searchSegue" {
                if let searchVC = segue.destination as? SearchDetailViewController {
                    searchVC.pokemonController = pokemonController
                }
            }
        }

    }
