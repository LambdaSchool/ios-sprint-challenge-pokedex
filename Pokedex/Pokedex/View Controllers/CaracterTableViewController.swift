//
//  CaracterTableViewController.swift
//  Pokedex
//
//  Created by morse on 5/10/19.
//  Copyright © 2019 morse. All rights reserved.
//

import UIKit

class CaracterTableViewController: UITableViewController {
    
    private let characterController = CharacterController()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return characterController.characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath)
        
        let character = characterController.characters[indexPath.row]
        cell.textLabel?.text = character.name

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            if let detailVC = segue.destination as? DetailViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    detailVC.character = characterController.characters[indexPath.row]
                }
                detailVC.characterController = characterController
            }
        } else if segue.identifier == "SearchSegue" {
            if let searchVC = segue.destination as? SearchViewController {
//                searchVC.characters = characterController.characters
                searchVC.characterController = characterController
            }
        }
    }
}

