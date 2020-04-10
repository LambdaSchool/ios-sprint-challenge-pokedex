//
//  PokemonTableViewController.swift
//  iOS-Pokedex
//
//  Created by Cameron Collins on 4/10/20.
//  Copyright © 2020 Cameron Collins. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //Variables
    var pokemonController = PokemonController()
    
    //Functions
    func updateViews() {
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemonAdded.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)

        cell.textLabel?.text =  pokemonController.pokemonAdded[indexPath.row].name

        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        guard let destination = segue.destination as? PokemonViewController else { return }
        
        if identifier == "searchSegue" {
            destination.delegate = self
            destination.pokemonController = pokemonController
        } else if identifier == "modifySegue" {
            destination.delegate = self
            destination.pokemonController = pokemonController
            if let row = tableView.indexPathForSelectedRow?.row {
                destination.selectedRow = row
                destination.displayedPokemon = pokemonController.pokemonAdded[row]
            }
        }
    }
}
