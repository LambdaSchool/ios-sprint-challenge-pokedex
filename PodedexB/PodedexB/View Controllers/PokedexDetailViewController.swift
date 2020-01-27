//
//  PokedexDetailViewController.swift
//  PodedexB
//
//  Created by Gerardo Hernandez on 1/26/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import UIKit
import SpriteKit

class PokedexDetailViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
 
    
    var pokedexController = PokedexController()
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        pokedexController.savePokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
        
        
    }
    
    
        private func updateViews() {
        guard let pokemon = pokemon else { return }
        
        DispatchQueue.main.async {
            self.nameLabel.text = "\(pokemon.name)"
            self.idLabel.text = "\(pokemon.id)"
            self.typesLabel.text = "\(pokemon.type)"
            self.abilitiesLabel.text = "\(pokemon.abilities)"
            
        }
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

extension PokedexDetailViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {return}
        
        pokedexController.pokemonSearch(for: searchText, completion:   { (result) in
            guard let result = try? result.get() else {return}
            
            DispatchQueue.global().async {
                self.pokemon = result
                self.pokedexController.fetchImage(at: (self.pokemon?.sprite.front_shiny)!, completion: { result in
                    
                    if let image = try? result.get() {
                        
                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }
                        
                    }
                })
            }
        })
    }
}
