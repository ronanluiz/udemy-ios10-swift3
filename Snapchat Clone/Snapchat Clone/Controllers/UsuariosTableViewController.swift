//
//  UsuariosTableViewController.swift
//  Snapchat Clone
//
//  Created by Ronan Luiz Araujo Eustaquio on 05/11/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class UsuariosTableViewController: UITableViewController {

    var usuariosCadastrados: [Usuario] = []
    var foto: Foto!
    let database = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carregarDados()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuariosCadastrados.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)
        let usuario = self.usuariosCadastrados[indexPath.row]
        
        celula.textLabel?.text = usuario.nome
        celula.detailTextLabel?.text = usuario.email
        
        return celula
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let usuarioSelecionado = usuariosCadastrados[indexPath.row]
        let idUsuarioSelecionado = usuarioSelecionado.uid
        
        // Estruturar o banco de dados para salvar os dados
        let database = Database.database().reference()
        let usuarios = database.child("usuarios")
        let snaps = usuarios.child(idUsuarioSelecionado).child("snaps")
        
        // recupera dados do usuário logado
        let autenticacao = Auth.auth()
        if let idUsuarioLogado = autenticacao.currentUser?.uid {
            // recupera dados do usuário no banco de dados
            let usuario = usuarios.child(idUsuarioLogado)
            usuario.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                let usuarioLogado = Usuario.parse(snapshot: snapshot)
                
                // Dicionario com dados do snap
                let snap = [
                    "de": usuarioLogado.email,
                    "nome": usuarioLogado.nome,
                    "descricao": self.foto.descricao,
                    "urlImagem": self.foto.urlImagem,
                    "idImagem": self.foto.idImagem
                ]
                
                // Salvando o snap com id gerado automaticamente
                snaps.childByAutoId().setValue(snap)
                
                // direciona para viewcontroller principal da navigation
                self.navigationController?.popToRootViewController(animated: true)
            })
        }
    }
    
    
    private func carregarDados() {
        let usuarios = database.child("usuarios")
        let autenticacao = Auth.auth()
        let idUsuarioLogado = autenticacao.currentUser?.uid
        usuarios.observe(DataEventType.childAdded, with: { (snapshot) in
            
            let usuario = Usuario.parse(snapshot: snapshot)
            
            if usuario.uid != idUsuarioLogado {
                self.usuariosCadastrados.append(usuario)
            }
            
            self.tableView.reloadData()
        })
    }
}
