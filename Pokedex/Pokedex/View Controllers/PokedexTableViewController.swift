//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Cody Morley on 4/10/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    
    
    var pokemonController = PokemonController()
    
   
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokedex.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokedexItemCell", for: indexPath) as? PokedexTableViewCell else { return UITableViewCell() }
        let pokemon = pokemonController.pokedex[indexPath.row]
        cell.pokemon = pokemon
        return cell
    }
    

   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            guard let destinationVC = segue.destination as? PokemonSearchViewController else { return }
            destinationVC.pokemonController = pokemonController
        }
        
        if segue.identifier == "DetailSegue" {
            guard let destinationVC = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.pokemon = pokemonController.pokedex[indexPath.row]
        }
    }
}
