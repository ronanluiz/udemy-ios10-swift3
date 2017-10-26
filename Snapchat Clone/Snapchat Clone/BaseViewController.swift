//
//  BaseViewController.swift
//  Snapchat Clone
//
//  Created by Ronan Luiz Araujo Eustaquio on 04/10/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit

enum CodigoErroAutenticacao: String {
    case EmailInvalido = "ERROR_INVALID_EMAIL"
    case SenhaFraca = "ERROR_WEAK_PASSWORD"
    case EmailEmUso = "ERROR_EMAIL_ALREADY_IN_USE"
    case SenhaInvalida = "ERROR_WRONG_PASSWORD"
    case UsuarioNaoEncontrado = "ERROR_USER_NOT_FOUND"
    
    var descricao: String {
        switch self {
        case .EmailInvalido:
            return "Email inválido"
        case .EmailEmUso:
            return "Email já está em usou"
        case .SenhaFraca:
            return "Utilize no mínimo 6 caracteres para senha"
        case .SenhaInvalida:
            return "Senha inválida"
        case .UsuarioNaoEncontrado:
            return "Usuário não encontrado"
        }
    }
}

class BaseViewController: UIViewController {

    func exibirMensagem(titulo: String, mensagem: String) {
        let alert = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addAction(acaoCancelar)
        present(alert, animated: true, completion: nil)
    }
    
    func exibirMensagem(alerta: Alerta) {
        let alert = alerta.getAlerta()
        present(alert, animated: true, completion: nil)
    }
}
