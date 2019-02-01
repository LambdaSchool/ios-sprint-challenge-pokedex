//
//  DetailViewController.swift
//  Networking Sprint Challenge - PokeDex
//
//  Created by Vijay Das on 2/1/19.
//  Copyright © 2019 Vijay Das. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
// OUTLETS
    
    @IBOutlet weak var pokeImage: UIImageView!
    
    @IBOutlet weak var pokeName: UILabel!
    
    @IBOutlet weak var pokeID: UILabel!
    
    @IBOutlet weak var pokeTypes: UILabel!
    
    @IBOutlet weak var pokeAbilities: UILabel!
    
}
