//
//  Usuario.swift
//  Snapchat Clone
//
//  Created by Ronan Luiz Araujo Eustaquio on 05/11/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Usuario {
    
    var nome: String
    var email: String
    var uid: String
    
    init() {
        self.nome = ""
        self.email = ""
        self.uid = ""
    }
    
    init(nome: String, email: String, uid: String) {
        self.nome = nome
        self.email = email
        self.uid = uid
    }
    
    static func parse(snapshot: DataSnapshot) -> Usuario {
        guard let dados = snapshot.value as? NSDictionary else {
            return Usuario()
        }
        
        let nome = dados["nome"] as! String
        let email = dados["email"] as! String
        let id = snapshot.key
        
        let usuario = Usuario(nome: nome, email: email, uid: id)
        
        return usuario
    }
}
