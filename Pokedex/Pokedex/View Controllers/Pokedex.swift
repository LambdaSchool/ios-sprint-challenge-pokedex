//
//  Pokedex.swift
//  Pokedex
//
//  Created by Shawn James on 4/10/20.
//  Copyright © 2020 Shawn James. All rights reserved.
//

import UIKit

class Pokedex: UITableViewController {
    
    // MARK: - Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPokemonBrain.userAddedPokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserPokemonCell", for: indexPath)
        cell.textLabel?.text = userPokemonBrain.userAddedPokemon[indexPath.row].name.capitalized
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            userPokemonBrain.userAddedPokemon.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAddPokemon" {
        } else if segue.identifier == "ShowPokemonDetails" {
            guard let addPokemonViewController = segue.destination as? AddPokemon else { return }
            guard let index = tableView.indexPathForSelectedRow?.row else { return }
            addPokemonViewController.selectedUserPokemon = userPokemonBrain.userAddedPokemon[index]
        }
    }
    
    
    // MARK: - App Brains
    let userPokemonBrain = UserPokemon()
    let networkingBrain = Networking()
    
}
