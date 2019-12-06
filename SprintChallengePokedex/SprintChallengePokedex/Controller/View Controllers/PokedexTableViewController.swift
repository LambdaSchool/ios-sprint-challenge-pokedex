//
//  PokedexTableViewController.swift
//  SprintChallengePokedex
//
//  Created by Chad Rutherford on 12/6/19.
//  Copyright © 2019 lambdaschool.com. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    let apiController = APIController()
    let pokemonController = PokemonController()
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        pokemonController.saveToPersistentStore()
        print(pokemonController.pokemon.count)
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segues.searchPokemonSegue:
            guard let pokeSearchVC = segue.destination as? PokedexSearchViewController else { return }
            pokeSearchVC.apiController = self.apiController
            pokeSearchVC.pokemonController = self.pokemonController
        default:
            break
        }
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - TableView DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.pokeCell, for: indexPath) as? PokedexTableViewCell else { return UITableViewCell() }
        let pokemon = pokemonController.pokemon[indexPath.row]
        cell.pokemon = pokemon
        return cell
    }
}
