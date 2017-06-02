//
//  ViewController.swift
//  Cara ou Coroa
//
//  Created by Ronan Luiz Araujo Eustaquio on 28/05/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "jogarMoedaSegue" {
            let numeroRandomico = arc4random_uniform(2)
            let viewControllerDestino = segue.destination as! DetalheViewController
            
            viewControllerDestino.numeroRandomico = Int(numeroRandomico)
        }
    }


}

