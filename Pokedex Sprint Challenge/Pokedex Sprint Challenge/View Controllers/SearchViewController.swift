//
//  SearchViewController.swift
//  Pokedex Sprint Challenge
//
//  Created by Mark Poggi on 4/10/20.
//  Copyright © 2020 Mark Poggi. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var searchPokemonController: SearchPokemonController?
    var pokemon: Pokemon?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }
    
    
    
    
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        titleLabel.text = pokemon.name
        idLabel.text = "\(pokemon.id)"
        var pokeAbilites = ""
        for abilityRoot in pokemon.abilities {
            pokeAbilites += abilityRoot.ability.name + " "
        }
        abilitiesLabel.text = pokeAbilites
        
        var pokeTypes = ""
        for typeRoot in pokemon.types {
            pokeTypes += typeRoot.type.name + " "
        }
        typesLabel.text = pokeTypes
        
        let URLImage = URL(string: pokemon.sprites.front_default)
        let session = URLSession(configuration: .default)
        let getImageFromURL = session.dataTask(with: URLImage!) { (data, response, error) in
            
            if let error = error {
                
                print("\(error)")
                
            } else {
                
                if(response as? HTTPURLResponse) != nil {
                    
                    if let imageData = data {
                        
                        let image = UIImage(data: imageData)
                        
                        self.imageView.image = image
                        
                    } else {
                        
                        print("No image found.")
                    }
                }
            }
        }
        
        getImageFromURL.resume()
    }
    
    
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // unwrap pokemon
        guard let pokemon = pokemon else { return }
        
        // save pokemon to array in pokemon controller
        searchPokemonController?.save(pokemon: pokemon)
        
        
        //pop to root view controller
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
}




extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        searchPokemonController?.performSearch(for: text, completion: { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let pokemon):
                self.pokemon = pokemon
                print(pokemon)
            }
            
            DispatchQueue.main.async {
                self.updateViews()
            }
            
        })
        
    }
}


