//
//  DetalheViewController.swift
//  Cara ou Coroa
//
//  Created by Ronan Luiz Araujo Eustaquio on 28/05/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import Foundation
import UIKit

class DetalheViewController: UIViewController {
    
    var numeroRandomico: Int!
    @IBOutlet weak var moedaImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if numeroRandomico == 0 {
            moedaImageView.image = #imageLiteral(resourceName: "moeda_cara")
        } else {
            moedaImageView.image = #imageLiteral(resourceName: "moeda_coroa")
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

