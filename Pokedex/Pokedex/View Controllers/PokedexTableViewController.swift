//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Matthew Martindale on 3/22/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    var pokemonController = PokemonController()
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
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

    @IBAction func segmentedControl(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            pokemonController.pokemonArray = pokemonController.sorter(sortedBy: .name)
            tableView.reloadData()
        case 1:
            pokemonController.pokemonArray = pokemonController.sorter(sortedBy: .id)
            tableView.reloadData()
        default:
            break
        }
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemonArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PokemonTableViewCell
        let pokemon = pokemonController.pokemonArray[indexPath.row]
        cell.pokemon = pokemon

        return cell
    }
    

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.pokemonArray.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            let searchVC = segue.destination as? SearchViewController
            searchVC?.pokemonController = pokemonController
        } else if segue.identifier == "DetailSegue" {
            if let pokemonIndex = tableView.indexPathForSelectedRow {
                let detailVC = segue.destination as? DetailViewController
                detailVC?.pokemonController = pokemonController
                detailVC?.pokemon = pokemonController.pokemonArray[pokemonIndex.row]
                print(pokemonController.pokemonArray[pokemonIndex.row])
            }
        }
    }


}
