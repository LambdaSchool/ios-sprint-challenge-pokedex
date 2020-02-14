//
//  SavedPokemonTableViewController.swift
//  Pokedex
//
//  Created by Austin Cole on 12/18/18.
//  Copyright © 2018 Austin Cole. All rights reserved.
//

import UIKit

class SavedPokemonTableViewController: UITableViewController {
    @IBOutlet weak var segmentedSort: UISegmentedControl!
    
    var savedPokemons = Model.shared.savedPokemons
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func segmentedSort(_ sender: Any) {
        
        switch segmentedSort.selectedSegmentIndex {
        case 2: savedPokemons = savedPokemons.sorted(by: {$0.id < $1.id})
        case 1: savedPokemons = savedPokemons.sorted(by: {$0.name < $1.name})
        default:
            savedPokemons = Model.shared.savedPokemons
        }
        tableView.reloadData()
        return
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.numberOfSavedPokemons
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = savedPokemons[indexPath.row].name
        
        guard let url = URL(string: (savedPokemons[indexPath.row].sprites.frontDefault)), let imageData = try? Data(contentsOf: url) else {return cell}
        cell.imageView?.image = UIImage(data: imageData)

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
        guard editingStyle == .delete else { return }
        
        // FIXME: Delete an item, update Firebase, update model, and reload data
        Model.shared.deletePokemon(indexPath: indexPath)
        self.tableView.reloadData()
    }

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? PokemonDetailViewController
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        let pokemon = savedPokemons[indexPath.row]
        
        destination?.pokemon = pokemon
    }

}
