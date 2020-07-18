//
//  PokedexTableViewController.swift
//  pokedex
//
//  Created by ronald huston jr on 5/28/20.
//  Copyright © 2020 HenryQuante. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    let pokemonController = PokemonController()
        
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
            return pokemonController.pokemonArray.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
            let pokemonFigure = pokemonController.pokemonArray[indexPath.row]
            guard let pokeImageData = try? Data(contentsOf: pokemonFigure.sprites.front) else { fatalError() }
            cell.imageView?.image = UIImage(data: pokeImageData)
            cell.textLabel?.text = pokemonFigure.name
            return cell
        }

        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                self.pokemonController.pokemonArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.reloadData()
            }
        }
       
        // MARK: - Navigation

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "DetailSegue" {
                guard let detailVC = segue.destination as? SearchDetailViewController,
                    let indexPath = tableView.indexPathForSelectedRow else { return }
                
                detailVC.pokemonController = pokemonController
                detailVC.pokemon = pokemonController.pokemonArray[indexPath.row]
            } else if segue.identifier == "SearchSegue" {
                if let searchVC = segue.destination as? SearchDetailViewController {
                    searchVC.pokemonController = pokemonController
                }
            }
        }

    }
