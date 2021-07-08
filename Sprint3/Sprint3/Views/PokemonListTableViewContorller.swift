//
//  PokemonListTableViewContorller.swift
//  Sprint3
//
//  Created by Victor  on 5/10/19.
//  Copyright © 2019 com.Victor. All rights reserved.
//

import Foundation
import UIKit

class PokemonListTableViewContorller: UITableViewController {
    
    //passing data
    let pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pokemonController.loadFromPersistentStore()
        tableView.reloadData()
    }
    
    //MARK: Configure
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let pokemon = pokemonController.pokemons[indexPath.row]
        
        //updating attributes
        cell.textLabel?.text = pokemon.name

        return cell
    }
    
    //MARK: Navigation
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "search", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "search" {
            guard let searchVC = segue.destination as? PokemonSearchViewController
                else { return }
            searchVC.pokemonController = pokemonController
            pokemonController.pokemon = nil
        } else if segue.identifier == "detail" {
            guard let searchVC = segue.destination as? PokemonSearchViewController,
                let indexPath = tableView.indexPathForSelectedRow
                else { return }
            
            pokemonController.pokemon = pokemonController.pokemons[indexPath.row]
            searchVC.pokemonController = pokemonController
            searchVC.searchBarAlpha = 0
            searchVC.saveButtonAlpha = 0
        }
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        navigationItem.backBarButtonItem?.tintColor = .white
        
    }

    //MARK: Editing
    
    //allows for deletion of row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pokemon = pokemonController.pokemons[indexPath.row]
            pokemonController.delete(pokemon: pokemon)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    //MARK: SectionHeader
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.white
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //updates header view ui
        view.tintColor = UIColor.white
        guard let header = view as? UITableViewHeaderFooterView else {return}
        
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        header.textLabel?.textColor = UIColor.lightGray
        header.textLabel?.textAlignment = .left
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //updates header height
        return 44
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //logic for each section
        if (section == 0) {
            return "Pokemon"
        } else {
            return nil
        }
    }
}
