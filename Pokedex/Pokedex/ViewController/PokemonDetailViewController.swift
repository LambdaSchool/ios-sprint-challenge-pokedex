//
//  ViewController.swift
//  Pokedex
//
//  Created by Bradley Yin on 8/9/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var apiController: APIController!
    
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        
    }
    
    func updateViews(with pokemon: Pokemon) {
        nameLabel.text = pokemon.name
        idLabel.text = "ID: \(pokemon.id)"
        var typeList = ""
        for type in pokemon.types {
            //if type == pokemon.types[pokemon.types.count - 1] {
            typeList.append("\(String(describing: type.type["name"])), " )
            //} else {
                //typeList.append("\(type.type["name"])" ?? "")
           // }
            
        }
        typeLabel.text = "Type: \(typeList)"
        
    }
    

}

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        apiController.searchPokemon(with: searchTerm) { (result) in
            guard let pokemon = try? result.get() else { return }
            self.apiController.fetchImage(imageURL: pokemon.sprites["front_default"]!, completion: { (dataResult) in
                guard let data = try? dataResult.get() else { return }
                DispatchQueue.main.async {
                    self.updateViews(with: animal)
                    self.animalImageView.image = UIImage(data: data)
                }
            })
        }
    }
}

