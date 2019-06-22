//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Kat Milton on 6/21/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    @IBOutlet var sortingSegment: UISegmentedControl!
    
    let pokemonController = PokemonController()
    
    private var pokemons: [Pokemon] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        print(pokemonController.pokemonList)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.tintColor = .white
        
        
    }
    
    
    @IBAction func sortPokemon(_ sender: UISegmentedControl) {
        updateDataSource()
    }
    
    private func updateDataSource() {
        if sortingSegment.selectedSegmentIndex == 0 {
            pokemonController.pokemonList = pokemonController.pokemonList.sorted(by: { $0.name < $1.name })
            
        } else {
            pokemonController.pokemonList = pokemonController.pokemonList.sorted(by: { $0.id < $1.id })
        }

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

    }
    
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemonList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonTableViewCell

        let pokemon = pokemonController.pokemonList[indexPath.row]
        cell.pokemonNameLabel.text = pokemon.name.capitalized
        cell.pokemonIDLabel.text = "Pokédex ID: \(pokemon.id)"
        
        guard let url = URL(string: pokemon.sprites.front_default),
            let pokemonSpriteData = try? Data(contentsOf: url) else { return UITableViewCell() }
        cell.pokemonSprite.image = UIImage(data: pokemonSpriteData)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            pokemonController.deletePokemon(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchForPokemon" {
            guard let destinationVC = segue.destination as? PokedexSearchViewController else { return }
            destinationVC.pokemonController = pokemonController
        } else if segue.identifier == "ShowPokemonDetails" {
            guard let destinationVC = segue.destination as? PokemonDetailViewController,
                let index = tableView.indexPathForSelectedRow else { return }
            let pokemon = pokemonController.pokemonList[index.row]
            destinationVC.pokemon = pokemon

        }
    }
    

}

