//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Ilgar Ilyasov on 9/21/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - Porperties
    
    var pokemonController: PokemonController?
    
    // MARK: - Outlets
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    
    
    // MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: - Search Bar Delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = pokemonSearchBar.text, !searchTerm.isEmpty else { return }
        
        pokemonController?.performSearch(searchTerm: searchTerm, completion: { (error) in
            DispatchQueue.main.async {
                if let error = error {
                    NSLog("Error performing search: \(error)")
                    return
                } else {
                    self.reloadInputViews()
                    self.view.endEditing(true)
                }
            }
        })
    }
}
