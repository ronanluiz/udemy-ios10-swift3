//
//  LocaisViagemViewController.swift
//  Minhas Viagens
//
//  Created by Ronan Luiz Araujo Eustaquio on 20/06/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit

class LocaisViagemViewController: UITableViewController {

    var locaisViagens = ["Cristo Redentor", "Praia de Pipa", "Praia do Forno"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        celula.textLabel?.text = viagem
        
        return celula
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
