//
//  ViewController.swift
//  project18
//
//  Created by Guillermo Alcalá Gamero on 29/11/2018.
//  Copyright © 2018 Guillermo Alcalá Gamero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Basic Swift debugging using print()
        // print(1, 2, 3, 4, 5, separator: "-")
        
        // Debugging with assert()
        // assert(1 == 1, "Maths failure!")
        
        // Debugging with breakpoints
        for i in 1 ... 100 {
            print("Got number \(i)")
        }
    }


}

