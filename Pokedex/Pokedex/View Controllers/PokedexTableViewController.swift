//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Madison Waters on 12/7/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.numberOfPokemon()
    }

    let reuseIdentifier = "PokeCell"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        //let pokemon = Model.shared.pokemon(at: indexPath.row)
        //cell.textLabel?.text = pokemon.name

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
            // Delete the row from the data source
        Model.shared.deletePokemon(at: indexPath.row)
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellToDetail" {
            guard let destination = segue.destination as? PokemonSearchViewController else { return }
            let indexPath = IndexPath()
            
            let pokemon = Model.shared.pokemon(at: indexPath.row)
            destination.pokemon = pokemon
        }
    }
}
