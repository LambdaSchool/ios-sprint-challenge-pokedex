//
//  UIController.swift
//  Pokemom Storyboard
//
//  Created by Alex Rhodes on 9/7/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation
import UIKit



class UIController {
    
    func searchBarConfiguration(_ searchBar: UISearchBar) {
        
        for subView in searchBar.subviews  {
            for subsubView in subView.subviews  {
                if let textField = subsubView as? UITextField {
                    var bounds: CGRect
                    bounds = textField.frame
                    bounds.size.height = 100//(set height whatever you want)
                    textField.bounds = bounds
                    textField.borderStyle = UITextField.BorderStyle.roundedRect
                    //                    textField.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
                    textField.backgroundColor = .white
                    //                    textField.font = UIFont.systemFontOfSize(20)
                }
            }
        }
        
        searchBar.searchBarStyle = .prominent
        
        searchBar.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        searchBar.barTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        //removes the top and bottom line
        searchBar.backgroundImage = UIImage()
    }
    
    func viewConfiguration(_ view: UIView) {
        
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
    }
    
    func tableViewConfiguration(_ tableView: UITableView) {
        
        tableView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
        tableView.separatorInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
    }
    
    
    func textFieldConfiguration(_ textField: UITextField) {
        
        textField.backgroundColor = .gray
    }
    
    
    func buttonConfiguration(_ sender: UIButton) {
        
        sender.backgroundColor = #colorLiteral(red: 0.3829096258, green: 0.6703189015, blue: 0.6273114681, alpha: 1)
        sender.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        sender.layer.cornerRadius = 6
        
    }
    
    
    func navigationControllerConfiguration(_ navController: UINavigationController) {
        
        // changing the navigation bars background color
        navController.navigationBar.barTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        // hidinh shadow under navigation view
        navController.navigationBar.setValue(true, forKey: "hidesShadow")
        
    }
    
    
}
