//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Jordan Christensen on 9/6/19.
//  Copyright © 2019 Mazjap Co Technologies. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    @IBOutlet var pokeballTextView: UITableView!
    
    let apiController = APIController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
    }
    
    func setUI() {
        navigationController?.navigationBar.barTintColor = UIColor(red:0.91, green:0.05, blue:0.07, alpha:1.00)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.00)]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.00)]
        
        view.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.00)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiController.pokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath)

        let tempPokemon = apiController.pokemon[indexPath.row]
        cell.textLabel?.text = tempPokemon.name
        
        cell.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.00)
        
        guard let url = URL(string: apiController.pokemon[indexPath.row].sprites.frontImage),
            let imageData = try? Data(contentsOf: url) else { fatalError() }
        cell.imageView?.image = UIImage(data: imageData)
        

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSearchSegue" {
            guard let detailVC = segue.destination as? PokemonDetailViewController else { return }
            detailVC.apiController = apiController
        } else if segue.identifier == "ShowPokeDetailSegue" {
            guard let detailVC = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
           detailVC.pokemon = apiController.pokemon[indexPath.row]
        }
    }
}
