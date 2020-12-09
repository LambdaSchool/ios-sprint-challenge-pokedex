//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by alfredo on 1/26/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    // MARK: - Properties
    
    var pokedexController: PokedexController!
    var userPokemonNamesSorted: [String]!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateProperties()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // MARK: - Methods
    
    private func updateProperties() {
        self.pokedexController = PokedexController()
        self.userPokemonNamesSorted = self.pokedexController.fetchPokemonNames(user: true, cached: false)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPokemonNamesSorted.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SavedPokemonCell", for: indexPath) as? SavedPokemonTableViewCell else { return UITableViewCell() }
        let row = indexPath.row
        let pokemonName = userPokemonNamesSorted[row]
        
        cell.pokemonLabel.text = pokemonName
        return cell
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "SearchSegue":
            guard let searchVC = segue.destination as? PokemonSearchTableViewController else { return }
            searchVC.pokedexController = self.pokedexController
            searchVC.delegate = self
        case "PokemonDetailSegue":
            guard segue.destination is PokemonDetailViewController else { return }
//            guard let cell = sender as? SavedPokemonTableViewCell else { return }
//            guard let pokemonName = cell.pokemonLabel.text else { return }
//            guard let pokemon = pokedexController.userPokedex[pokemonName] else { return }
//            pokemonDetailVC.pokemon = pokemon
//            pokemonDetailVC.delegate = self
//            pokemonDetailVC.pokedexController = self.pokedexController
        default:
            break
        }
    }
}

extension PokedexTableViewController: SavePokemon {
    func updateSavedPokemon(){
//        userPokedexPokemonNamesSorted = pokedexController.getUserPokemonNamesSorted()
        tableView.reloadData()
    }
}
