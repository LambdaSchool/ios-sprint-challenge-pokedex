//
//  ViewController.swift
//  Pokemon
//
//  Created by Nick Nguyen on 2/14/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

protocol PokemonDetailVCDelegate : AnyObject {
    func didReceivePokemon(with pokemon: Pokemon)
}

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var saveButton: UIButton!
     
    var pokemon: Pokemon?
    
    var apiController = APIController()
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar! {
        didSet {
            pokemonSearchBar.delegate = self
            pokemonSearchBar.becomeFirstResponder()
        }
    }
    weak var delegate: PokemonDetailVCDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeAbiLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokeTypeLabel: UILabel!
    @IBOutlet weak var pokeIdLabel: UILabel!
    
    private func updateViews() {
        nameLabel.text = "\(apiController.pokemon.name.uppercased())"
        pokeIdLabel.text = "ID :\(apiController.pokemon.id)"
    }
   
    
    
    @IBAction func saveTapped(_ sender: UIButton) {
        
        delegate?.didReceivePokemon(with: Pokemon(id: apiController.pokemon.id, name: apiController.pokemon.name))
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let pokemon = pokemon {
                  nameLabel.text = "\(apiController.pokemon.name.uppercased())"
                  pokeIdLabel.text = "ID :\(apiController.pokemon.id)"
                  title = "\(apiController.pokemon.name.uppercased())"
              }
              title = "Pokemon Search"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
    }


}



extension PokemonDetailVC : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
     
        apiController.performSearch(searchTerm: searchTerm) { (error) in
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
     
        
      
    }
}
