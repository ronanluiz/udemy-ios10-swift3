//
//  ViewController.swift
//  Estudo Firebase
//
//  Created by Ronan Luiz Araujo Eustaquio on 09/08/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var codigo: UITextField!
    @IBOutlet weak var descricao: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func salvar(_ sender: Any) {
        if let codigo = codigo.text,
            let descricao = descricao.text {
        
            let database = Database.database().reference()
            
            let produtosDataBase = database.child("produtos")
            produtosDataBase.child(codigo)
                            .child("descricao")
                            .setValue(descricao)
            
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}

