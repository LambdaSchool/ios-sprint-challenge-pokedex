//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Cody Morley on 4/10/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
        print("hello world")
    }
    
    @IBAction func savePokemon(_ sender: Any) {
        guard let unwrappedPokemon = pokemon else { return }
        pokemonController?.savePokemon(pokemon: unwrappedPokemon)
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func updateViews() {
        //unwrap pokemon object
        
        // give values to IBOutlets to the values of the pokemon object
        
        
    }
    
}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Hello again")
        guard let text = searchBar.text else {
            print("error")
            return }
        print(text)
        pokemonController?.getPokemon(for: text, completion: { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let pokemon):
                print(pokemon)
                self.pokemon = pokemon
                //call updateViews() in the main thread (GDOT)
            }
        })
    }
}
