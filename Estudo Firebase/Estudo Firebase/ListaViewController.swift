//
//  ListaViewController.swift
//  Estudo Firebase
//
//  Created by Ronan Luiz Araujo Eustaquio on 09/08/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ListaViewController: UITableViewController {
    
    fileprivate let idCelula = "celula"
    fileprivate var produtos: [Produto] = []
    @IBOutlet var clientTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // configura a célula da tabela
        self.clientTable.register(UITableViewCell.self, forCellReuseIdentifier: idCelula)
        
        configureDatabase()
    }

    fileprivate func configureDatabase(){
        let database = Database.database().reference()
        
        let produtosDataBase = database.child("produtos")
        
        produtosDataBase.observe(.childAdded, with: { (dados) in
            if let produto = Produto.parse(codigo: dados.key, dados: dados.value as? [String: Any]) {
                self.adicionar(item: produto)
            }
        })
        
        produtosDataBase.observe(.childRemoved, with: { (dados) in
            if let indice = self.produtos.index(where: { $0.codigo == dados.key }) {
                self.remover(indice: indice)
            }
        })
    }
    
    fileprivate func adicionar(item: Produto){
        produtos.append(item)
        clientTable.beginUpdates()
        clientTable.insertRows(at: [IndexPath(row: self.produtos.count-1, section: 0)], with: .automatic)
        clientTable.endUpdates()
    }
    
    fileprivate func remover(indice: Int){
        produtos.remove(at: indice)
        clientTable.beginUpdates()
        clientTable.deleteRows(at: [IndexPath(row: indice, section: 0)], with: .automatic)
        clientTable.endUpdates()
    }
    
    fileprivate func excluir(indice: Int) {
        let database = Database.database().reference()
        
        if produtos.indices.contains(indice) {
            let produto = self.produtos[indice]
            database.child("produtos")
                    .child(produto.codigo)
                    .removeValue()
            
        }
    }
}


extension ListaViewController {
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return produtos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCelula, for: indexPath)
        
        let item = produtos[indexPath.row]
        
        cell.textLabel?.text = item.descricao
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let indice = indexPath.row
            excluir(indice: indice)
            remover(indice: indice)
        }
    }
}

