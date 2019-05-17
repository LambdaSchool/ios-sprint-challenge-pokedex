//
//  PokemonSearchViewController.swift
//  Sprint3
//
//  Created by Kobe McKee on 5/17/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {

    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    
    
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var pokemonTypes: UILabel!
    @IBOutlet weak var pokemonAbilities: UILabel!
    
    func searchPokemon(_ searchBar: UISearchBar) {
        
        
        
    }
    
    @IBAction func savePokemonClicked(_ sender: UIButton) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
