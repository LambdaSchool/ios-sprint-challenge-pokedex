//
//  SavedPokémonListViewController.swift
//  Pokédex
//
//  Created by Jason Modisett on 9/14/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import UIKit

class SavedPokemonListViewController: UIViewController, UITableViewDataSource {

    // MARK:- View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        parent?.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    
    // MARK:- UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokémonController.savedPokémon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.savedPokemon.rawValue, for: indexPath) as? SavedPokemonTableViewCell else { return UITableViewCell() }
        
        let pokémon = pokémonController.savedPokémon[indexPath.row]
        cell.pokémon = pokémon
        
        let imageManager = ImageCacheManager()
        
        imageManager.fetchImage(url: URL(string: pokémon.sprites.frontDefault)!, completion: { image in
            if let image = image {
                DispatchQueue.main.async { cell.spriteImageView.image = image }
            }
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pokémon = pokémonController.savedPokémon[indexPath.row]
            pokémonController.removeFromPokédex(pokémon: pokémon) { (error) -> (Void) in
                DispatchQueue.main.async { self.tableView.deleteRows(at: [indexPath], with: .automatic) }
            }
        }
    }

    
    // MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? PokemonDetailsViewController else { return }
        destVC.pokémonController = pokémonController
        
        if segue.identifier == SegueIdentifiers.details.rawValue {
            guard let index = tableView.indexPathForSelectedRow?.row else { return }
            
            let pokémon = pokémonController.savedPokémon[index]
            destVC.pokémon = pokémon
            destVC.isUserSearching = false
            
        } else { destVC.isUserSearching = true }
    }
    
    
    // MARK:- Properties & types
    let pokémonController = PokémonController()
    
    
    // MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
}
