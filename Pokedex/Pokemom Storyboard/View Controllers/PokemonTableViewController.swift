//
//  PokemonTableViewController.swift
//  Pokemom Storyboard
//
//  Created by Alex Rhodes on 9/6/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    var pokedexController = PokedexController()
    
    let ui = UIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokedexController.loadFromPersistentStore()
        setViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pokedexController.loadFromPersistentStore()
        tableView.reloadData()
        setViews()
    }
    
    // MARK: - Table view data source
    
    private func setViews() {
        ui.tableViewConfiguration(tableView)
        ui.navigationControllerConfiguration(navigationController!)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokedexController.pokemons.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        let pokemon = pokedexController.pokemons[indexPath.row]
        cell.textLabel?.text = pokemon.name
        cell.textLabel?.font = UIFont(name: "System Bold", size: 15)
        cell.detailTextLabel?.text = String(pokemon.id)
        cell.detailTextLabel?.textColor = .red
        cell.detailTextLabel?.font = UIFont(name: "System Medium", size: 14)
        cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        
        return cell
    }
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            guard let destinationVC = segue.destination as? RealDetailViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
            destinationVC.pokedexController = pokedexController
            destinationVC.pokemon = pokedexController.pokemons[indexPath.row]
        } else  if segue.identifier == "SearchSegue" {
            guard let destinationVc = segue.destination as? DetailViewController else {return}
            destinationVc.pokedexController = pokedexController
        }
        
    }
    
    
}
