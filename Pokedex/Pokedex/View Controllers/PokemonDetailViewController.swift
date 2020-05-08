//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Nonye on 5/8/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemonController: PokemonController? {
        didSet {
            //TODO
        }
    }
    
    var pokemon: Pokemon? {
        didSet {
            //TODO
        }
    }
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var type: UILabel!
    
    @IBOutlet weak var ability: UITextView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO
    }
    
    // MARK: - ACTION
    @IBAction func saveButtonTapped(_ sender: Any) {
        // TODO
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //TODO - EXTENSION 4 SEARCH BAR?
    func searchBarSearchButtonClicked(_ sender: UISearchBar) {
        
    }
}
