//
//  DetalhesSnapViewController.swift
//  Snapchat Clone
//
//  Created by Ronan Luiz Araujo Eustaquio on 23/11/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit
import SDWebImage

class DetalhesSnapViewController: UIViewController {

    var snap = Snap()
    @IBOutlet weak var fotoImageView: UIImageView!
    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var contadorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carregarDados()
    }
    
    private func carregarDados() {
        descricaoLabel.text = snap.descricao
        
        let urlImagem = URL(string: snap.urlImagem)
        // método da biblioteca SDWebImage que 
        // faz o download da imagem e carrega automaticamente a partir de uma url
        fotoImageView.sd_setImage(with: urlImagem) { (image, error, cache, url) in
            if error == nil {
                print("imagem carregada")
            }
        }
    }
}
