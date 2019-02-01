//
//  SearchViewController.swift
//  Networking Sprint Challenge - PokeDex
//
//  Created by Vijay Das on 2/1/19.
//  Copyright © 2019 Vijay Das. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    // OUTLETS
    
    @IBOutlet weak var resultImage: UIImageView!
    
    @IBOutlet weak var resultNameLabel: UILabel!
    @IBOutlet weak var resultIDLabel: UILabel!
    @IBOutlet weak var resultTypeLabel: UILabel!
    @IBOutlet weak var resultAbilitiesLabel: UILabel!
    
    var pokemonController: PokemonController?
    
    var result: Pokemon?
    // {
    // didSet {
    // updateViews()
    // }

    override func viewDidLoad() {
        super.viewDidLoad()
        // updateViews()
    }

// updateViews method needs to be added
    
    func updateViews() {
        guard let result = result else { return}
        resultNameLabel.text = result.name.capitalized
        resultIDLabel.text = "\(result.id)"
        
        
        let ability = result.abilities.map { $0.subAbility.name}
        let type = result.type.map { $0.subType}
        
        resultAbilitiesLabel.text = ability.first
        resultTypeLabel.text = type.first
        
        
        pokemonController?.fetchImage(for: result, completion: { (data) in
            guard let data = data else { return }
            
            let image = UIImage(data: data)
            self.resultImage.image = image
            
        })
   
    }
    
    
    
    

    
//    @IBOutlet weak var searchBar: UISearchBar!

    
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        guard let result = result else { return }
        pokemonController?.savePokemon(pokemon: result)
        navigationController?.popViewController(animated: true)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty,
        let pokemonController = pokemonController else { return }
        
   

        
        
        
        
}

}
