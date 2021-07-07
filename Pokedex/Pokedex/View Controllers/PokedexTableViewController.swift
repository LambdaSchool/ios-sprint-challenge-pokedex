//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Jake Connerly on 6/21/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    
    //
    //MARK: - Properties
    //
    
    let pokeController = PokeController()
    
    
    //
    //MARK: - View LifeCycle
    //


    override func viewDidLoad() {
        super.viewDidLoad()


    }

    //
    // MARK: - Table view data source
    //

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeController.pokeList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath)

        cell.textLabel?.text = pokeController.pokeList[indexPath.row].name

        return cell
    }

    //
    // MARK: - Navigation
    //
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddPokeSegue" {
            if let addPokeVC = segue.destination as? PokeDetailViewController {
                addPokeVC.pokeController = pokeController
            }
        }else if segue.identifier == "ShowPokeSegue" {
            if let showPokeVC = segue.destination as? PokeDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                showPokeVC.pokeController = pokeController
                showPokeVC.pokemon = pokeController.pokeList[indexPath.row]
            }
        }
    }
    

}
