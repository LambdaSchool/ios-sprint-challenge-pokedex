//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Marissa Gonzales on 5/8/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    private var pokeResultController = PokemonResultsController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeResultController.pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        cell.textLabel?.text = pokeResultController.pokemons[indexPath.row].name
        return cell
    }
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            if let searchDetailVC = segue.destination as? DetailTableViewController {
                searchDetailVC.pokeResultController = self.pokeResultController
            }
        } else if segue.identifier == "DetailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow,
            let detailVC = segue.destination as? DetailTableViewController {
                detailVC.pokeResultController = self.pokeResultController
                detailVC.pokemon = self.pokeResultController.pokemons[indexPath.row]
            }
        }
    }
}
