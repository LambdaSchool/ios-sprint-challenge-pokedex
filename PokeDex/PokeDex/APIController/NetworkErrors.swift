//
//  NetworkErrors.swift
//  PokeDex
//
//  Created by Chris Gonzales on 2/14/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import Foundation

struct NetworkErrors {
    
    enum errors: Error {
        case badURL
        case otherError
        case badData
    }
}
