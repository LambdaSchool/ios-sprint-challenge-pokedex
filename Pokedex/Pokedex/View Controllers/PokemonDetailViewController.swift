//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Shawn Gee on 3/13/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    // MARK: - Properties
    
    var pokemon: Pokemon?
    
    // MARK: - Private
    
    private func updateImageView() {
        guard let pokemon = pokemon else { return }
        
        // pick image
        // fetch image
        // display image in callback
    }
    
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        title = pokemon.name
        idLabel.text = "ID: \(pokemon.id)"
        typesLabel.text = pokemon.types.map { $0.name }.joined(separator: ", ")
        abilitiesLabel.text = pokemon.abilities.map { $0.name }.joined(separator: ", ")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
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
