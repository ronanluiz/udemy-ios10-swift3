//
//  CadastroViewController.swift
//  Snapchat Clone
//
//  Created by Ronan Luiz Araujo Eustaquio on 17/08/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit
import FirebaseAuth

class CadastroViewController: BaseViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var senhaConfirmacao: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // exibe barra de navegação
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    @IBAction func criarConta(_ sender: Any) {
        
        if let email = email.text,
           let senha = senha.text,
           let senhaConfirmacao = senhaConfirmacao.text {
            
            if senha == senhaConfirmacao {
                let autenticacao = Auth.auth()
                autenticacao.createUser(withEmail: email, password: senha, completion: { (usuario, erro) in
                    if erro == nil {
                            self.performSegue(withIdentifier: "cadastroLoginSegue", sender: nil)
                    } else {
                        let erroRecuperado = erro! as NSError
                        if let nomeErro = erroRecuperado.userInfo["error_name"]{
                            let codigoErro = CodigoErroAutenticacao(rawValue: nomeErro as? String ?? "")
                            let descricaoErro = String(format: "%@.", codigoErro?.descricao ?? "")
                            self.exibirMensagem(titulo: "Dados incorretos", mensagem: descricaoErro)
                        }
                    }
                })
                
            } else {
                exibirMensagem(titulo: "Dados incorretos", mensagem: "A senha e sua confirmação não conferem.")
            }
        }
    }
}
