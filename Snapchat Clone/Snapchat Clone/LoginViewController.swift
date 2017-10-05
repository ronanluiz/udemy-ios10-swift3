//
//  LoginViewController.swift
//  Snapchat Clone
//
//  Created by Ronan Luiz Araujo Eustaquio on 16/08/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: BaseViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var senhaText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // exibe barra de navegação
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    @IBAction func entrar(_ sender: Any) {
        if let email = emailText.text,
           let senha = senhaText.text {
            
            let autenticacao = Auth.auth()
            autenticacao.signIn(withEmail: email, password: senha, completion: { (usuario, erro) in
                if erro == nil {
                    if usuario == nil {
                        self.exibirMensagem(titulo: "Erro ao autenticar", mensagem: "Problema ao realizar autenticação, tente novamente.")
                        
                    } else {
                        self.performSegue(withIdentifier: "loginSegue", sender: nil)
                    }
                    
                } else {
                    let erroRecuperado = erro! as NSError
                    if let nomeErro = erroRecuperado.userInfo["error_name"]{
                        let codigoErro = CodigoErroAutenticacao(rawValue: nomeErro as? String ?? "")
                        let descricaoErro = String(format: "%@.", codigoErro?.descricao ?? "")
                        self.exibirMensagem(titulo: "Dados incorretos", mensagem: descricaoErro)
                    }
                }
            })
            
        }
    }
}
