//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Angel Buenrostro on 1/25/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    
    var pokemonController: PokemonController?
    
    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                print("This is the didSet func: \(self.pokemon?.name)")
                self.updateViews()
                
            }
        }
    }
    @IBOutlet weak var search: UISearchBar!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var spriteImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        search.delegate = self
        DispatchQueue.main.async {
            self.searchBarSearchButtonClicked(self.search)
        }
        
        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(_ search: UISearchBar) {
        guard let searchTerm = search.text, !searchTerm.isEmpty else { return }
        
        pokemonController?.searchPokemon(searchTerm: searchTerm, completion: { (error) in
            print("Search Button was Clicked!!!!!")
            
            DispatchQueue.main.async {
                self.updateViews()
                print("Pokemon Name: \(self.pokemon?.name)")
                print("\(self.pokemonController?.pokemon!.name)")
            }
        })
    }
    
    
    func updateViews(){
        guard let pokemon = self.pokemonController?.pokemon! else {
            print("Pokemon var is nil")
            return
        }
       
            self.nameLabel.text = pokemon.name
            let url = pokemon.sprites["front_default"]
            if let data = try? Data(contentsOf: url!!){
                    spriteImage.image = UIImage(data: data)
                }
            self.idLabel.text = String(pokemon.id)
            self.abilitiesLabel.text = pokemon.abilities[0].name
            self.typesLabel.text = pokemon.types[0].name
        
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
