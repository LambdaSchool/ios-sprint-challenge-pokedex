//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Madison Waters on 12/9/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Model.shared.updateHandler = { self.tableView.reloadData() }
    }
    
    deinit {
        Model.shared.updateHandler = nil
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.numberOfPokemon()
    }
    
    let reuseIdentifier = "PokeCell"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        let pokemon = Model.shared.findPokemon(at: indexPath.row)
        cell.textLabel?.text = pokemon.name
        
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        Model.shared.deletePokemon(index: indexPath.row)
        
    }
    
    // MARK: - Navigation
    // PokemonDetail // SearchPokedex

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destination = segue.destination as? PokeDetailViewController else { return }
            
            let pokemon = Model.shared.findPokemon(at: indexPath.row)
            destination.pokemon = pokemon
            
        } else if segue.identifier == "SearchPokedex" {
            guard let destination = segue.destination as? PokeDetailViewController else { return }
            let pokemon = Model.shared.pokemon
            destination.pokemon = pokemon
        }
    }

}
