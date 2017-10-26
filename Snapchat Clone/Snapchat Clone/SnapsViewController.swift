//
//  SnapsViewController.swift
//  Snapchat Clone
//
//  Created by Ronan Luiz Araujo Eustaquio on 25/10/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit
import FirebaseAuth

class SnapsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func sair(_ sender: UIBarButtonItem) {
        let autenticacao = Auth.auth()
        do {
            try autenticacao.signOut()
            dismiss(animated: true, completion: nil)
        } catch {
            let alerta = Alerta(titulo: "Autenticação", mensagem: "Erro ao tentar deslogar.")
            exibirMensagem(alerta: alerta)
        }
        
    }
}
