//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Farhan on 9/14/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var spriteView: UIImageView!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var captureButton: UIButton!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?{
        didSet{
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        captureButton.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        
        pokemonController?.fetchPokemon(name: searchText, completion: { (_, pokemon) in
            guard let pokemon = pokemon else { return }
            
            self.pokemon = pokemon
            
            DispatchQueue.main.async {
                self.captureButton.isHidden = false
            }
            
        })
        searchBar.resignFirstResponder()
    }
    
    @IBAction func capturePokemon(_ sender: Any) {
        
        self.pokemonController?.createPokemon(pokemon: pokemon!)
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    func updateView(){
        
        guard let pokemon = pokemon else { return }
        
        guard let imageURL = URL(string: pokemon.imageURL) else {return}
        
        do {
            let imageData = try Data(contentsOf: imageURL)
            spriteView.image = UIImage(data: imageData)
        } catch {
            NSLog("Could not use ImageData: \(error)")
            return
        }
        
        
        idLabel.text = "ID: \(pokemon.id)"
        nameLabel.text = "Name: \(pokemon.name)"
        weightLabel.text = "Weight: \(pokemon.weight) kg"
        typeLabel.text = "Type(s): \(pokemon.types.joined(separator: " + "))"
        abilitiesLabel.text = "Abilities: \(pokemon.abilities.joined(separator: " & "))"
        
        
    }
}

    

   
    

