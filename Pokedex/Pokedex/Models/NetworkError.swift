//
//  NetworkError.swift
//  Pokedex
//
//  Created by Jessie Ann Griffin on 9/15/19.
//  Copyright © 2019 Jessie Griffin. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case otherError
    case badData
    case noDecode
}
