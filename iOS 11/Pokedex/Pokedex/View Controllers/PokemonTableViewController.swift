//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by brian vilchez on 11/1/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import UIKit


enum SegueIdentifiers: String {
    case AddPokemon
    case PokemonDetail
}

class PokemonTableViewController: UITableViewController {

    //MARK: - properties
    var pokemonAPI = PokemonAPIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonAPI.pokemons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonTableViewCell else {return UITableViewCell()}
        let pokemon = pokemonAPI.pokemons[indexPath.row]
        cell.pokemon = pokemon
        return cell
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case SegueIdentifiers.AddPokemon.rawValue:
            guard let addPokemonVC = segue.destination as? PokemonDetailViewController else { return }
            addPokemonVC.pokemonAPI = pokemonAPI
            
        case SegueIdentifiers.PokemonDetail.rawValue:
            guard let pokemonDetailVC = segue.destination as? PokemonDetailViewController,
                let pokemonIndexPath = tableView.indexPathForSelectedRow else { return }
            pokemonDetailVC.pokemon = pokemonAPI.pokemons[pokemonIndexPath.row] 
        default:
            break
        }
    }
    

}
