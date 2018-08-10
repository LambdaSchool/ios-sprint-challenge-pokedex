//
//  PokemonSearchViewController.swift
//  ios-sprint-3
//
//  Created by Lambda-School-Loaner-11 on 8/10/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

private let key = "savePokemon"

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    
    let pokemonController = PokemonController()
    

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var pokemonLabel: UILabel!
    
    @IBOutlet weak var pokemonID: UILabel!
    
    @IBOutlet weak var pokemonType: UILabel!
    
    @IBOutlet weak var pokemonAbility: UILabel!
    
    
    @IBAction func savePokemonButton(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        defaults.setValue("savePokemon", forKey: key)
        
        navigationController?.popViewController(animated: true)
    }
    
    func searchBarClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        pokemonController.performSearch(with: searchTerm) { (error) in
            if let error = error {
                NSLog("\(error)")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
}
