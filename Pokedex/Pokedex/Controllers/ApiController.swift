//
//  ApiController.swift
//  Pokedex
//
//  Created by Chris Dobek on 4/10/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case push = "PUSH"
}

 enum NetworkError: Error {
    case otherError
    case badData
    case noDecode
    case noData
}

class APIController {

}
