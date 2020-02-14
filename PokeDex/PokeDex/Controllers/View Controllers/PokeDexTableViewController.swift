//
//  PokeDexTableViewController.swift
//  PokeDex
//
//  Created by Aaron Cleveland on 1/17/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import UIKit

class PokeDexTableViewController: UITableViewController {
    
    let auth = Auth()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return auth.pokemonArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemonAnimal = auth.pokemonArray[indexPath.row]
        cell.textLabel?.text = pokemonAnimal.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            auth.pokemonArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            guard let detailVC = segue.destination as? PokeDexDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            detailVC.auth = auth
            detailVC.pokemon = auth.pokemonArray[indexPath.row]
        } else if segue.identifier == "SearchSegue" {
            if let searchVC = segue.destination as? PokeDexDetailViewController {
                searchVC.auth = auth
            }
        }
    }
}
