//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_268 on 2/14/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var actualDetails: UILabel!
    @IBOutlet weak var typeNameLabel: UILabel!
    @IBOutlet weak var actualTypes: UILabel!
    
    @IBOutlet weak var actualAbilities: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var spriteView: UIImageView!
    
    // MARK: - PROPERTIES
    
    var APIController: PokemonAPIController?
    var pokemon: Pokemon?
    
    // MARK: - METHODS
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        
        if let 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
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
