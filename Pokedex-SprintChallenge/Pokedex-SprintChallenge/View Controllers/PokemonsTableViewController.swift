//
//  PokemonsTableViewController.swift
//  Pokedex-SprintChallenge
//
//  Created by morse on 11/1/19.
//  Copyright © 2019 morse. All rights reserved.
//

import UIKit

class PokemonsTableViewController: UITableViewController {
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    struct PropertyKeys {
        static let cell = "PokemonCell"
        static let addSegue = "ShowAddPokemonSegue"
        static let detailSegue = "ShowDetailSegue"
    }
    
    let pokeController = PokeController()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        sortPokemon()
    }
    
    func sortPokemon() {
        switch segmentedController.selectedSegmentIndex {
        case 0:
            pokeController.sortBy(type: .name)
        default:
            pokeController.sortBy(type: .id)
        }
        tableView.reloadData()
    }
    
    @IBAction func sortChanged(_ sender: UISegmentedControl) {
        sortPokemon()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokeController.pokemons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.cell, for: indexPath)

        cell.textLabel?.text = pokeController.pokemons[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            pokeController.delete(pokeController.pokemons[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == PropertyKeys.addSegue {
            if let addVC = segue.destination as? PokemonDetailViewController {
                addVC.pokeController = pokeController
            }
        } else if segue.identifier == PropertyKeys.detailSegue {
            if let detailVC = segue.destination as? PokemonDetailViewController, let indexPath = tableView.indexPathForSelectedRow {
                detailVC.pokeController = pokeController
                detailVC.pokemon = pokeController.pokemons[indexPath.row]
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
