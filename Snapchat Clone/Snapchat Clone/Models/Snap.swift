//
//  Snap.swift
//  Snapchat Clone
//
//  Created by Ronan Luiz Araujo Eustaquio on 23/11/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Snap {
    var identificador = ""
    var nome = ""
    var de = ""
    var descricao = ""
    var urlImagem = ""
    var idImagem = ""
    
    static func parse(snapshot: DataSnapshot) -> Snap {
        let model = Snap()
        
        guard let dados = snapshot.value as? NSDictionary else {
            return model
        }
        
        model.identificador = snapshot.key
        model.nome = dados["nome"] as! String
        model.de = dados["de"] as! String
        model.descricao = dados["descricao"] as! String
        model.urlImagem = dados["urlImagem"] as! String
        model.idImagem = dados["idImagem"] as! String
        
        return model
    }
    
}
