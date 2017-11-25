//
//  SnapsViewController.swift
//  Snapchat Clone
//
//  Created by Ronan Luiz Araujo Eustaquio on 25/10/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SnapsViewController: BaseViewController {

    internal var snaps: [Snap] = []
    @IBOutlet internal weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        carregarDados()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalheSnapSegue",
           let vc = segue.destination as? DetalhesSnapViewController,
           let snap = sender as? Snap {
            vc.snap = snap
        }
    }
    
    @IBAction func sair(_ sender: UIBarButtonItem) {
        let autenticacao = Auth.auth()
        do {
            try autenticacao.signOut()
            dismiss(animated: true, completion: nil)
        } catch {
            let alerta = Alerta(titulo: "Autenticação", mensagem: "Erro ao tentar deslogar.")
            exibirMensagem(alerta: alerta)
        }
    }
    
    private func carregarDados() {
        let autenticacao = Auth.auth()
        if let idUsuarioLogado = autenticacao.currentUser?.uid {
            let database = Database.database().reference()
            let usuariosDb = database.child("usuarios")
            let snapsDb = usuariosDb.child(idUsuarioLogado).child("snaps")
            snapsDb.observe(DataEventType.childAdded, with: { (snapshot) in
                
                let snap = Snap.parse(snapshot: snapshot)
                self.snaps.append(snap)
                self.tableView.reloadData()
            })
        }
    }
    
    
}

extension SnapsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let totalLinhas = snaps.count
        if totalLinhas == 0 {
            return 1
        }
        
        return totalLinhas
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)
        
        let totalLinhas = snaps.count
        if totalLinhas == 0 {
            celula.textLabel?.text = "Nenhum snap pra você :)"
        } else {
            let model = snaps[indexPath.row]
            celula.textLabel?.text = model.nome
        }
        return celula
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if snaps.count > 0 {
            let snap = snaps[indexPath.row]
            performSegue(withIdentifier: "detalheSnapSegue", sender: snap)
        }
    }
}
