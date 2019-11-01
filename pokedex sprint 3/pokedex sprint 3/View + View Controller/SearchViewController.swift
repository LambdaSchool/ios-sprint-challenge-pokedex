//
//  SearchViewController.swift
//  pokedex sprint 3
//
//  Created by Rick Wolter on 11/1/19.
//  Copyright © 2019 Richar Wolter. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    
     var pokemonController: PokemonController?
       
        @IBOutlet weak var searchBar: UISearchBar!
        @IBOutlet weak var nameLabel: UILabel!
        @IBOutlet weak var typeLabel: UILabel!
        @IBOutlet weak var idLabel: UILabel!
        @IBOutlet weak var abilityLabel: UILabel!
        @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var saveButton: UIButton!
    
    var pokemon: Pokemon? {
           didSet {
               DispatchQueue.main.async {
                   self.updateViews()
               }
           }
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.delegate = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        pokemonController?.search(searchTerm: searchTerm, completion: { (pokemon, error) in
            if let error = error {
                NSLog("error finding pokemon with \(searchTerm): \(error)")
                return
            }
            self.pokemon = pokemon
            
            guard let url = pokemon?.imageSprites.frontDefault else { return }
            self.pokemonController?.fetchImage(url: url , completion: { (data) in
                self.pokemon?.imageData = data
            })
        })
        self.searchBar.endEditing(true)
    }
    
    @IBAction func savePokemon(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokemonController?.createPokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        guard let pokemon = pokemon,
            let imageData = pokemon.imageData else { return }
        
       
        nameLabel.text = pokemon.name
        idLabel.text = "ID: \(pokemon.id)"
        
        let typeString = pokemon.type.map {$0.type.name}.joined(separator: "/")
        typeLabel.text = "Types: \(typeString)"
        
        let abilityString = pokemon.ability.map {$0.ability.name}.joined(separator: ", ")
        abilityLabel.text = "Abilities: \(abilityString)"
        
        imageView.isHidden = false
        imageView.image = UIImage(data: imageData)
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
