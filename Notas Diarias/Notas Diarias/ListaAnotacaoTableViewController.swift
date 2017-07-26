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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
