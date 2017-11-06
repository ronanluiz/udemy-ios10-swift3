//
//  Foto.swift
//  Snapchat Clone
//
//  Created by Ronan Luiz Araujo Eustaquio on 06/11/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import Foundation

class Foto {
    var descricao: String
    var urlImagem: String
    var idImagem: String
    
    init(descricao: String, urlImagem: String, idImagem: String) {
        self.descricao = descricao
        self.urlImagem = urlImagem
        self.idImagem = idImagem
    }
}

