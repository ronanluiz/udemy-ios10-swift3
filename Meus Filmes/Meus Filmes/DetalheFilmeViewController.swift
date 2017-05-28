//
//  DetalheFilmeViewController.swift
//  Meus Filmes
//
//  Created by Ronan Luiz Araujo Eustaquio on 28/05/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import Foundation
import UIKit

class DetalheFilmeViewController: UIViewController {
    
    var filme: Filme!
    @IBOutlet weak var filmeImageView: UIImageView!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var descricaoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filmeImageView.image = filme.imagem
        tituloLabel.text = filme.titulo
        descricaoLabel.text = filme.descricao
    }
}
