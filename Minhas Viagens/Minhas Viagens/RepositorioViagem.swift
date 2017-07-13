//
//  RepositorioViagem.swift
//  Minhas Viagens
//
//  Created by Ronan Luiz Araujo Eustaquio on 24/06/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import Foundation

class RepositorioLocalViagem {
    
    let chaveArmazenamento = "locaisViagem"
    var viagens: [[String:String]] = []
    var repositorio: UserDefaults {
        return UserDefaults.standard
    }
    
    func salvar(_ viagem: [String:String]){
        
        var viagens = listar()
        
        viagens.append(viagem)
        
        salvar(viagens: viagens)
    }
    
    func salvar(viagens: [[String:String]]){
        
        repositorio.set(viagens, forKey: chaveArmazenamento)
        // força a sincronização do UserDefaults em tempo real, sem aguardar o tempo default de sincronização automática
        repositorio.synchronize()
    }
    
    func listar() -> [[String:String]] {
        
        guard let dados = repositorio.object(forKey: chaveArmazenamento) else {
            return []
        }
        
        return dados as! [[String:String]]
    }
    
    func remove(indice: Int){
        
        var viagens = listar()
        
        viagens.remove(at: indice)
        
        salvar(viagens: viagens)
    }
}
