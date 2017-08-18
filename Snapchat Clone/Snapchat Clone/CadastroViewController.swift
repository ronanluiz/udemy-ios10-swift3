//
//  CadastroViewController.swift
//  Snapchat Clone
//
//  Created by Ronan Luiz Araujo Eustaquio on 17/08/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit

class CadastroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // exibe barra de navegação
        navigationController?.setToolbarHidden(false, animated: false)
    }
}
