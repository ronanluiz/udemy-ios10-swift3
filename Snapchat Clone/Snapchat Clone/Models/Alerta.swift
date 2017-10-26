//
//  Alerta.swift
//  Snapchat Clone
//
//  Created by Ronan Luiz Araujo Eustaquio on 26/10/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit

class Alerta {
    var titulo: String
    var mensagem: String
    
    init(titulo: String, mensagem: String) {
        self.titulo = titulo
        self.mensagem = mensagem
    }
    
    func getAlerta() -> UIAlertController {
        let alert = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addAction(acaoCancelar)
        
        return alert
    }
    
}
