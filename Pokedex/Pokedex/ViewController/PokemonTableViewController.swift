//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Bradley Yin on 8/9/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    let apiController = APIController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return apiController.pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        cell.textLabel?.text = apiController.pokemons[indexPath.row].name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? PokemonDetailViewController else { return }
        if segue.identifier == "SearchShowSegue" {
            detailVC.apiController = apiController
        }
        if segue.identifier == "DetailShowSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            detailVC.apiController = apiController
            detailVC.fromCell = true
            detailVC.pokemon = apiController.pokemons[indexPath.row]
        }
    }

}
