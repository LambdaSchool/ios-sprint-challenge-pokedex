//
//  SearchViewController.swift
//  Networking Sprint Challenge - PokeDex
//
//  Created by Vijay Das on 2/1/19.
//  Copyright © 2019 Vijay Das. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    var pokemonController: PokemonController?
    
    var result: Pokemon?
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBOutlet weak var searchBar: UISearchBar!

    
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        guard let result = result else { return }
        pokemonController?.savePokemon(pokemon: result)
        navigationController?.popViewController(animated: true)
        
    }
    
   

}
