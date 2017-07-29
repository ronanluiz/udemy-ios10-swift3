//
//  ListaAnotacaoTableViewController.swift
//  Notas Diarias
//
//  Created by Ronan Luiz Araujo Eustaquio on 17/07/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit
import CoreData

class ListaAnotacaoTableViewController: UITableViewController {

    var gerenciadorContexto: NSManagedObjectContext!
    var anotacoes: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurarContexto()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        recuperarAnotacoes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return anotacoes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)

        let anotacao = anotacoes[indexPath.row]
        let texto = anotacao.value(forKey: "texto") as? String
        let formatacaoData = DateFormatter()
        formatacaoData.dateFormat = "dd/MM/yyyy hh:mm"
        let data = formatacaoData.string(from: anotacao.value(forKey: "data") as! Date)
        
        cell.textLabel?.text = texto
        cell.detailTextLabel?.text = data
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // remove a seleção da célula
        tableView.deselectRow(at: indexPath, animated: true)
        
        let anotacaoSelecionada = anotacoes[indexPath.row] as? NSManagedObject
        performSegue(withIdentifier: "verAnotacao", sender: anotacaoSelecionada )
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verAnotacao" {
            let viewControllerDestino = segue.destination as! AnotacaoViewController
            viewControllerDestino.anotacao = sender as? NSManagedObject
        }
    }
    
    func configurarContexto() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        gerenciadorContexto = appDelegate.persistentContainer.viewContext
    }
    
    func recuperarAnotacoes() {
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Anotacao")
        
        do {
            
            let anotacoesRecuperadas = try gerenciadorContexto.fetch(requisicao)
            self.anotacoes = anotacoesRecuperadas as! [NSManagedObject]
            
            tableView.reloadData()
            
        } catch let error as NSError {
            print("Erro ao tentar recuperar os dados: \(error.description)")
        }
    }

}
