//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Jonathan T. Miles on 8/10/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokedex.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        cell.textLabel?.text = pokemonController.pokedex[indexPath.row].name
        return cell
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.deletePokemon(pokemon: pokemonController.pokedex[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "SearchSegue":
            let destVC = segue.destination as! SearchTableViewController
            destVC.pokemonController = pokemonController
        case "ShowDetailSegue":
            let destVC = segue.destination as! PokemonDetailViewController
            destVC.pokemonController = pokemonController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            destVC.pokemon = pokemonController.pokedex[indexPath.row]
        default:
            return
        }
    }
    
    // MARK: - Properties
    
    let pokemonController = PokemonController()

}
