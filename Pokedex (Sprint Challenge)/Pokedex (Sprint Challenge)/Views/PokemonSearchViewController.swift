//
//  PokemonSearchViewController.swift
//  Pokedex (Sprint Challenge)
//
//  Created by Nathan Hedgeman on 7/12/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    //Properties
    var pokemon: Pokemon?
    var pokemonController: PokemonController?

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
    //Labels
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var idDetailsLabel: UILabel!
    
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var typeDetailsLabel: UILabel!
    
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var abilityDetailsLabel: UILabel!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let x = ""
        idLabel.text = x
        idDetailsLabel.text = x
        typesLabel.text = x
        typeDetailsLabel.text = x
        abilityLabel.text = x
        abilityDetailsLabel.text = x
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchPoke = searchBar.text else { return }
        pokemonController?.searchForPokemon(pokemonName: searchPoke, completion: { (result) in
            DispatchQueue.main.async {
                self.idLabel.text = "id"
                idDetailsLabel.text = "\(result.get().id)"
            }
        })
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        func savePokemon() {
            
            guard let pokemon = pokemon else { return }
            pokemonController?.pokemonList.append(pokemon)
        }
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
