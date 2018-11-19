//
//  Person.swift
//  project10
//
//  Created by Guillermo Alcalá Gamero on 19/11/2018.
//  Copyright © 2018 Guillermo Alcalá Gamero. All rights reserved.
//

import UIKit

class Person: NSObject {

    var name: String
    var image: String
 
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
}
