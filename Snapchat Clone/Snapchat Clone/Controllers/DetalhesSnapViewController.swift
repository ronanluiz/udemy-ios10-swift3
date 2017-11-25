//
//  DetalhesSnapViewController.swift
//  Snapchat Clone
//
//  Created by Ronan Luiz Araujo Eustaquio on 23/11/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class DetalhesSnapViewController: UIViewController {

    private var tempoTimer = 10
    
    var snap = Snap()
    @IBOutlet weak var fotoImageView: UIImageView!
    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var contadorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carregarDados()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        excluirSnap()
        excluirImagem()
    }
    
    private func carregarDados() {
        descricaoLabel.text = "Carregando..."
        
        let urlImagem = URL(string: snap.urlImagem)
        // método da biblioteca SDWebImage que 
        // faz o download da imagem e carrega automaticamente a partir de uma url
        fotoImageView.sd_setImage(with: urlImagem) { (image, error, cache, url) in
            if error == nil {
                self.descricaoLabel.text = self.snap.descricao
                self.contadorLabel.text = String(self.tempoTimer)
                self.executarTimer()
            }
        }
    }
    
    private func excluirSnap() {
        let autenticacao = Auth.auth()
        if let idUsuario = autenticacao.currentUser?.uid {
            let database = Database.database().reference()
            let usuarioDb = database.child("usuarios").child(idUsuario)
            let snapsDb = usuarioDb.child("snaps")
            
            // exclui o nó do snap do banco de dados
            snapsDb.child(snap.identificador).removeValue()
        }
    }
    
    private func excluirImagem() {
        let storage = Storage.storage().reference()
        let imagensStorage = storage.child("imagens")
        
        let idImagem = "\(snap.idImagem).jpg"
        imagensStorage.child(idImagem).delete { (error) in
            if error == nil {
                print("Imagem \(idImagem) removida com sucesso!")
            } else {
                print("Erro ao tentar remover a imagem \(idImagem)")
            }
        }
    }
    
    private func executarTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            // decrementa o contador
            self.tempoTimer = self.tempoTimer - 1
            
            // atualiza a tela
            self.contadorLabel.text = String(self.tempoTimer)
            
            if self.tempoTimer == 0 {
                // para o timer
                timer.invalidate()
                // fecha a tela
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
