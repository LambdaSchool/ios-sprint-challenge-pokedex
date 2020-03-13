//
//  PokemonDetailViewController.swift
//  PokeDex
//
//  Created by Nichole Davidson on 3/13/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeslabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
        // MARK: - Properties
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func getDetails() {
        guard let pokemon = pokemon else { return }
        
        pokemonController?.pokemonSearch(searchTerm: <#T##String#>, completion: <#T##(Error?) -> Void#>)
    }
    
    private func updateViews(with pokemon: Pokemon) {
        title = pokemon.name
        nameLabel.text = pokemon.name
        idLabel.text = "ID: \(pokemon.id)"
        
        pokemonImage = pokemon.sprite
                
    }
    
    @IBAction func savePokemonTapped(_ sender: Any) {
        
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

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchButtonClicked(_searchBar: UISearchBar) {
        
    }
}
