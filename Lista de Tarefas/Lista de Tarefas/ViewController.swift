//
//  ViewController.swift
//  Lista de Tarefas
//
//  Created by Ronan Luiz Araujo Eustaquio on 02/06/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var tarefas: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        atualizarTarefas()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        atualizarTarefas()
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tarefas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaTabela", for: indexPath)
        celula.textLabel?.text = tarefas[indexPath.row]
        
        return celula
    }
    
    /**
     Evento que permite definir ação de exclusão no table view
     */
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let tarefaBusiness = TarefaBusiness()
            tarefaBusiness.excluir(indice: indexPath.row)
            
            atualizarTarefas()
            tableView.reloadData()
        }
    }
    
    func atualizarTarefas() {
        let tarefaBusiness = TarefaBusiness()
        tarefas = tarefaBusiness.listar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

