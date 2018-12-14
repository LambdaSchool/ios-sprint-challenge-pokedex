//
//  PokemonSearchViewController.swift
//  Podex II
//
//  Created by Ivan Caldwell on 12/14/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    
    // Variables and Constants
    var pokemon: Pokemon?
    let endpoint = "https://pokeapi.co/api/v2/pokemon/"
    
    // Outlets and Actions
    @IBOutlet weak var pokemonNameTitle: UINavigationItem!
    @IBOutlet weak var pokemonAbilityLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonSave: UIButton!
    
    @IBAction func savePokemon(_ sender: Any) {
        PokemonModel.shared.pokemons.append(pokemon!)
        navigationController?.popViewController(animated: true)
    }
    
    
    // Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar, completion: @escaping (Error?) -> Void ) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        // Build the webaddress
        let url = URL(string: endpoint + searchTerm.lowercased())
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Error: No data returend from data task")
                completion(NSError())
                return
            }
            do {
                self.pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                var index = 0
                var abilities: String = "Ability: "
                while index < self.pokemon?.abilities.count ?? 0 {
                    abilities += " \(self.pokemon!.abilities[index].ability.name),"
                    index += 1
                }
                abilities.removeLast()
                index = 0
                var types: String = "Type: "
                print ("Type Count: \(self.pokemon!.types.count)")
                while index < self.pokemon?.types.count ?? 0 {
                    types += " \(self.pokemon!.types[index].type.name),"
                    index += 1
                }
                types.removeLast()
                let imageURL = URL(string: (self.pokemon?.sprites?.frontDefault)!)
                let imageData = try Data(contentsOf: imageURL!)
                
                DispatchQueue.main.async {
                    self.pokemonNameTitle.title = self.pokemon?.name
                    self.pokemonIDLabel.text = "ID: \(self.pokemon!.id)"
                    self.pokemonIDLabel.textColor = UIColor.black
                    self.pokemonTypeLabel.text = types
                    self.pokemonTypeLabel.textColor = UIColor.black
                    self.pokemonAbilityLabel.text = abilities
                    self.pokemonAbilityLabel.textColor = UIColor.black
                    self.pokemonImage.image = UIImage(data: imageData)
                    self.pokemonSave.setTitleColor( UIColor(displayP3Red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
                }
            } catch {
                print(error)
            }
        }.resume()
        
    }
}
