//
//  TarefaBusiness.swift
//  Lista de Tarefas
//
//  Created by Ronan Luiz Araujo Eustaquio on 02/06/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import Foundation

class TarefaBusiness {
    
    let chaveListaTarefas = "chaveListaTarefas"
    var tarefas: [String] = []
    
    func salvar(forTarefa tarefa: String){
        tarefas = listar()
        
        tarefas.append(tarefa)
        
        UserDefaults.standard.set(tarefas,  forKey: chaveListaTarefas)
    }
    
    func listar() -> [String] {
        
        let dados = UserDefaults.standard.object(forKey: chaveListaTarefas)
        
        if dados is [String] {
            return dados as! [String]
        } else {
            return []
        }
    }
    
    func excluir(indice: Int){
        tarefas = listar()
        
        tarefas.remove(at: indice)
        
        UserDefaults.standard.set(tarefas,  forKey: chaveListaTarefas)
    }
}
