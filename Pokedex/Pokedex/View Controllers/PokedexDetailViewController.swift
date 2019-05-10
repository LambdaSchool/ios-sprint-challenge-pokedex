//
//  PokedexDetailViewController.swift
//  Pokedex
//
//  Created by Alex on 5/10/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class PokedexDetailViewController: UIViewController, UISearchBarDelegate {

    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var idLbl: UILabel!
    @IBOutlet var typesLbl: UILabel!
    @IBOutlet var abilitiesLbl: UILabel!
    @IBOutlet var savePokemonBtn: UIButton!
    
    // MARK: - Actions
    @IBAction func savePokemonBtnPressed(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateViews()
    }
    
    func updateViews(){
         guard let pokemon = pokemon, isViewLoaded else { return }
        
        nameLbl.text = pokemon.name
        idLbl.text = String(pokemon.id)
        typesLbl.text = pokemon.types[0].type
        abilitiesLbl.text = pokemon.abilities[0].ability
        
//        pokemonController?.fetchImage(url: pokemon, completion: { (data) in
//            guard let data = data else { return }
//
//            let image = UIImage(data: data)
//            self.imageView.image = image
//        })
    }
            
}
