//
//  MainTableViewController.swift
//  pokedex
//
//  Created by Joshua Sharp on 9/6/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    let pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.savedPokemon.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = pokemonController.savedPokemon[indexPath.row].name
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let vc = segue.destination as? DetailViewController else { return }
        if segue.identifier == "SearchSegue" {
            vc.pokemonController = self.pokemonController
            vc.searching = true
        } else if segue.identifier == "DetailSegue" {
            vc.pokemonController = self.pokemonController
            vc.searching = false
            guard let index = tableView.indexPathForSelectedRow else { return }
            let pokemon = pokemonController.savedPokemon[index.row]
            vc.pokemon = pokemon
        }
    }
}
