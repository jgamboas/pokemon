//
//  PokemonDetailController.swift
//  pokemon
//
//  Created by Jason Gamboa Solano on 24/8/22.
//

import Foundation
import UIKit

class PokemonDetailController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
     func openSheet() {
        // Create the view controller.
        let sheetViewController = 
        
        // Present it w/o any adjustments so it uses the default sheet presentation.
        present(sheetViewController, animated: true, completion: nil)
    }
}
