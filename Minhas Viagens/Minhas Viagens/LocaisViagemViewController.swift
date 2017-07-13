//
//  LocaisViagemViewController.swift
//  Minhas Viagens
//
//  Created by Ronan Luiz Araujo Eustaquio on 20/06/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit

enum controleNavegacao {
    case listar
    case adicionar
}

class LocaisViagemViewController: UITableViewController {
    
    var locaisViagens: [Dictionary<String, String>]
    var controleNavegacaoSelecionado: controleNavegacao
    
    required init?(coder aDecoder: NSCoder) {
        self.locaisViagens = []
        self.controleNavegacaoSelecionado = .adicionar
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.controleNavegacaoSelecionado = .adicionar
        recarregarLocais()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locaisViagens.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viagem = locaisViagens[indexPath.row]
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)
        
        celula.textLabel?.text = viagem["local"]
        
        return celula
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            RepositorioLocalViagem().remove(indice: indexPath.row)
            recarregarLocais()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controleNavegacaoSelecionado = .listar
        // abre a tela de mapa passando o índice do item selecionado
        performSegue(withIdentifier: "localMapa", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "localMapa" {
            
            let viewControllerDestino = segue.destination as! ViewController
            
            switch controleNavegacaoSelecionado {
            case .listar:
                if let indiceSelecionado = sender {
                    
                    let indice = indiceSelecionado as! Int
                    viewControllerDestino.viagem = locaisViagens[indice]
                    viewControllerDestino.indiceSelecionado = indice
                }
                break
            default:
                viewControllerDestino.viagem = [:]
                viewControllerDestino.indiceSelecionado = nil
                break
            }
        }
    }
    
    func recarregarLocais() {
        
        locaisViagens = RepositorioLocalViagem().listar()
        tableView.reloadData()
    }
}
