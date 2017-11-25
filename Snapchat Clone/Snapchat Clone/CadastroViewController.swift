//
//  CadastroViewController.swift
//  Snapchat Clone
//
//  Created by Ronan Luiz Araujo Eustaquio on 17/08/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CadastroViewController: BaseViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var senhaConfirmacao: UITextField!
    @IBOutlet weak var nomeCompletoText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // exibe barra de navegação
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    // força a exibição/ocultação do teclado
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func criarConta(_ sender: Any) {
        
        if let email = email.text,
            let senha = senha.text,
            let senhaConfirmacao = senhaConfirmacao.text,
            let nomeCompleto = nomeCompletoText.text {
            
            if nomeCompleto.characters.count > 0 {
                
                if senha == senhaConfirmacao {
                    let autenticacao = Auth.auth()
                    autenticacao.createUser(withEmail: email, password: senha, completion: { (usuario, erro) in
                        if erro == nil {
                            if usuario == nil {
                                self.exibirMensagem(titulo: "Erro de Autenticação", mensagem: "Problemas na autenticação. Tente novamente mais tarde.")
                                
                            } else {
                                // Cria usuário no banco de dados
                                let database = Database.database().reference()
                                let usuarios = database.child("usuarios")
                                
                                let usuarioDados = ["nome": nomeCompleto, "email": email]
                                
                                usuarios.child(usuario!.uid).setValue(usuarioDados)
                                
                                self.performSegue(withIdentifier: "cadastroLoginSegue", sender: nil)
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
                    
                } else {
                    exibirMensagem(titulo: "Dados incorretos", mensagem: "A senha e sua confirmação não conferem.")
                }
            } else {
                exibirMensagem(titulo: "Dados incorretos", mensagem: "Informe o nome completo para cadastro.")
            }
            
        }
    }
}
