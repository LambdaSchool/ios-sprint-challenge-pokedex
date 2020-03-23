//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Lambda_School_loaner_226 on 3/23/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    let apiController = APIController()
    
    var pokemon: Pokemon! {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiController.pokemonArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        
        let pokemonCharacter = apiController.pokemonArray[indexPath.row]
        cell.textLabel?.text = pokemonCharacter.name
        return cell
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsSegue" {
            guard let detailVC = segue.destination as? SearchDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else {return}
            detailVC.apiController = apiController
            detailVC.pokemon = apiController.pokemonArray[indexPath.row]
            print("DetailViewSegue hit")
            
        }else if segue.identifier == "SearchSegue" {
            if let searchVC = segue.destination as? SearchDetailViewController {
                searchVC.apiController = apiController
            }
        }
    }
}
