//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Sammy Alvarado on 7/20/20.
//  Copyright © 2020 Sammy Alvarado. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    let reuseIdentifiter = "PokemonCell"

    private var pokemonNames: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }

     let apiController = APIController()

    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           tableView.reloadData()
       }

    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return apiController.newPokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifiter, for: indexPath)

//        cell.textLabel?.text = pokemonNames[indexPath.row]

        let pokemon = apiController.newPokemon[indexPath.row]
        cell.textLabel?.text = pokemon.name.capitalized
        return cell
    }

    // MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokemonSegue" {
            guard let searchVC = segue.destination as? PokemonSearchViewController else { return }
//            if let indexPath = tableView.indexPathForSelectedRow {
//                searchVC.pokemonN = pokemonNames[indexPath.row]

            searchVC.apiController = apiController
        }
        else if segue.identifier == "ShowPokemonSegue" {
            guard let showVC = segue.destination as? PokemonDetailViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let pokemon = apiController.newPokemon[indexPath.row]
            showVC.pokemon = pokemon
        }
    }


}
