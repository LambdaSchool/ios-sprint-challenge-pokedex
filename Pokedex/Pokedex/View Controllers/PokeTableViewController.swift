//
//  PokeTableViewController.swift
//  Pokedex
//
//  Created by Alexander Supe on 12/8/19.
//  Copyright © 2019 Alexander Supe. All rights reserved.
//

import UIKit

class PokeTableViewController: UITableViewController {
    
    //Attributes
    var pokeContr = PokeController()
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeContr.addedPokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath) as? PokeTableViewCell
        cell?.pokemon = pokeContr.addedPokemon[indexPath.row]
        return cell!
    }
    
    // Deletion
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokeContr.removePokemon(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addSegue" {
            
            guard let destination = segue.destination as? PokeAddViewController else { return }
            destination.pokeContr = self.pokeContr
        } else if segue.identifier == "showSegue" {
            
            guard let destination = segue.destination as? PokeDetailViewController else { return }
            destination.pokemon = self.pokeContr.addedPokemon[tableView.indexPathForSelectedRow?.row ?? 0]
        }
    }
}
