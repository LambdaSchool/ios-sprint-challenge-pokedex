//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by alfredo on 1/26/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokedexController = PokedexController()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    // MARK: - Properties
    
    var pokedexController: PokedexController!
    var savedPokemon: [String] = []
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedPokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SavedPokemonCell", for: indexPath) as? SavedPokemonTableViewCell else { return UITableViewCell() }
        let row = indexPath.row
        let pokemonName = savedPokemon[row]
        
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
            guard let pokemonDetailVC = segue.destination as? PokemonDetailViewController else { return }
            guard let cell = sender as? SavedPokemonTableViewCell else { return }
            guard let pokemonName = cell.pokemonLabel.text else { return }
            guard let pokemon = pokedexController.pokedex[pokemonName] else { return }
            pokemonDetailVC.pokemon = pokemon
            pokemonDetailVC.delegate = self
            pokemonDetailVC.pokedexController = self.pokedexController
        default:
            break
        }
    }
}

extension PokedexTableViewController: SavePokemon{
    func updateSavedPokemon(){
        savedPokemon = pokedexController.getSavedPokemon()
        tableView.reloadData()
    }
}
