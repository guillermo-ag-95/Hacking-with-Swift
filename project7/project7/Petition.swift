//
//  Petition.swift
//  project7
//
//  Created by Guillermo Alcalá Gamero on 14/11/2018.
//  Copyright © 2018 Guillermo Alcalá Gamero. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
