//
//  Filme.swift
//  Meus Filmes
//
//  Created by Ronan Luiz Araujo Eustaquio on 28/05/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import Foundation
import UIKit

class Filme {
    
    var titulo: String!
    var descricao: String!
    var imagem: UIImage!
    
    init(titulo: String, descricao: String, imagem: UIImage) {
        self.titulo = titulo
        self.descricao = descricao
        self.imagem = imagem
    }
    
}
