//
//  CadastroViewController.swift
//  Snapchat Clone
//
//  Created by Ronan Luiz Araujo Eustaquio on 17/08/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit
import FirebaseAuth

enum CodigoErroCadastro: String {
    case EmailInvalido = "ERROR_INVALID_EMAIL"
    case SenhaFraca = "ERROR_WEAK_PASSWORD"
    case EmailEmUso = "ERROR_EMAIL_ALREADY_IN_USE"
    
    var descricao: String {
        switch self {
        case .EmailInvalido:
            return "Email inválido"
        case .EmailEmUso:
            return "Email já está em usou"
        case .SenhaFraca:
            return "Utilize no mínimo 6 caracteres para senha"
        }
    }
}

class CadastroViewController: UIViewController {

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
    
    func exibirMensagem(titulo: String, mensagem: String) {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alerta.addAction(acaoCancelar)
        showAlertGlobally(alerta)
    }
    
    // Utility function to avoid:
    // Warning: Attempt to present * on * whose view is not in the window hierarchy!
    func showAlertGlobally(_ alert: UIAlertController) {
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.windowLevel = UIWindowLevelAlert
        alertWindow.rootViewController = UIViewController()
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func criarConta(_ sender: Any) {
        
        if let email = email.text,
           let senha = senha.text,
           let senhaConfirmacao = senhaConfirmacao.text {
            
            if senha == senhaConfirmacao {
                let autenticacao = Auth.auth()
                autenticacao.createUser(withEmail: email, password: senha, completion: { (usuario, erro) in
                    if erro == nil {
                        self.exibirMensagem(titulo: "Cadastro Usuário", mensagem: "Usuário cadastrado com sucesso!")
                    } else {
                        let erroRecuperado = erro! as NSError
                        if let nomeErro = erroRecuperado.userInfo["error_name"]{
                            let codigoErro = CodigoErroCadastro(rawValue: nomeErro as? String ?? "")
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
