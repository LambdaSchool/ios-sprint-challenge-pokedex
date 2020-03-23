//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Juan M Mariscal on 3/20/20.
//  Copyright © 2020 Juan M Mariscal. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    let apiController = APIController()

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.reloadData()
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiController.pokeList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        let pokemon = apiController.pokeList[indexPath.row]
        cell.textLabel?.text = pokemon.name.capitalized

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokemonSegue",
            let searchVC = segue.destination as? PokeSearchViewController {
            searchVC.apiController = apiController
        } else if segue.identifier == "PokemonDetailSegue",
            let detailVC = segue.destination as? PokemonDetailViewController, let indexpath = tableView.indexPathForSelectedRow {
                let pokemon = self.apiController.pokeList[indexpath.row]
                detailVC.apiController = self.apiController
                detailVC.pokemon = pokemon
        }
    }
    

}
