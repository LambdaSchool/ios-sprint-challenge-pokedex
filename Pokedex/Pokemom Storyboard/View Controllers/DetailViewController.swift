//
//  DetailViewController.swift
//  Pokemom Storyboard
//
//  Created by Alex Rhodes on 9/6/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let pokedexController = PokedexController()
    
    var pokemon: Pokemon?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var savePokemonButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }
    
    func setViews() {
        
        guard let pokemon = pokemon else {return}
        
        idLabel.text = String(pokemon.id)
        nameLabel.text = pokemon.name
        
    }
    
    @IBAction func savePokemonButton(_ sender: Any) {
        
    }
    
}

extension DetailViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        guard let searchTerm = searchBar.text else {return}
        
        pokedexController.preformSearch(with: searchTerm) { (error) in
            DispatchQueue.main.async {
                self.setViews()
            }
        }
    }
}
