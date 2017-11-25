//
//  Produto.swift
//  Estudo Firebase
//
//  Created by Ronan Luiz Araujo Eustaquio on 09/08/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import Foundation

class Produto {
    
    var codigo: String!
    var descricao: String!
    var dataAtualicao: Date!
    
    static func parse(codigo: String, dados: [String: Any]?) -> Produto? {
        guard let dados = dados, dados.count > 0 else {
            return nil
        }
        
        let produto = Produto()
        produto.codigo = codigo
        produto.descricao = dados["descricao"] as? String
        return produto
    }
}
