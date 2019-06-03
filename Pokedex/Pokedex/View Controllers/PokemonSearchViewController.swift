//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Stephanie Bowles on 6/2/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var pokeNameLabel: UILabel!
    
    @IBOutlet weak var spriteView: UIImageView!
    
    @IBOutlet weak var pokeIDLabel: UILabel!
    @IBOutlet weak var pokeTypesLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController : PokemonController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    func updateViews() {
        
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
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
