//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Farhan on 9/14/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabwl: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var tableViewController: PokemonTableViewController?
    
    var pokemonController: PokemonController?
    
    var pokemon: Pokemon?{
        didSet{
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    @IBAction func searchPokemon(_ sender: Any) {
    //
    //        guard let name = searchBar.text else {return}
    //        pokemonController?.fetchPokemon(name: name, completion: { (_) in
    //
    //        })
    //        updateViews()
    //
    //    }
    @IBAction func exit(_ sender: Any)
    {navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func savePokemon(_ sender: Any) {
        
        guard let name = searchBar.text?.lowercased(), let tableViewController = tableViewController else {return}
        pokemonController?.fetchPokemon(name: name, completion: { (_) in
            
        })
        
        tableViewController.tableView.reloadData()
        
        print(pokemonController?.pokemons)
        updateViews()
        
        
        
    }
    
    func updateViews(){
        guard let pokemon = pokemon else {return}
        nameLabel.text = pokemon.name
        idLabel.text = String(pokemon.id)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
