//
//  SearchPokemonViewController.swift
//  iOSSprintChallengePokedex
//
//  Created by denis cedeno on 11/9/19.
//  Copyright © 2019 DenCedeno Co. All rights reserved.
//

import UIKit

class SearchPokemonViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var typesLabel: UILabel!
    
    @IBOutlet weak var attributesLabel: UILabel!
    
    @IBAction func savePokemonButton(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
      
    }
    


}
