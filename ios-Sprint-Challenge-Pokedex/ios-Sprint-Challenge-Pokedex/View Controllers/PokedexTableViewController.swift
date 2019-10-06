//
//  PokedexTableViewController.swift
//  ios-Sprint-Challenge-Pokedex
//
//  Created by Jonalynn Masters on 10/5/19.
//  Copyright © 2019 Jonalynn Masters. All rights reserved.
//

import UIKit

class PokedexTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: Properties
    let apiController = APIController()
    
    var pokemon: Pokemon! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return apiController.pokemonArray.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokedexTableViewCell", for: indexPath)

        let pokemonCharacter = apiController.pokemonArray[indexPath.row]
        cell.textLabel?.text = pokemonCharacter.name
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewSegue" {
            if let detailVC = segue.destination as? SearchDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow{
                detailVC.pokemon = apiController.pokemonArray[indexPath.row]
            }
        } else if segue.identifier == "SearchPokemonSegue" {
            if let searchVC = segue.destination as? SearchDetailViewController {
                searchVC.apiController = apiController
            }
        }
    }
}

