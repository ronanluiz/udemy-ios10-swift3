//
//  ViewController.swift
//  Notas Diarias
//
//  Created by Ronan Luiz Araujo Eustaquio on 17/07/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit
import CoreData

class AnotacaoViewController: UIViewController {

    var contextManager: NSManagedObjectContext!
    
    @IBOutlet weak var texto: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // inicializando contexto do core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        contextManager = appDelegate.persistentContainer.viewContext
        
        // força abrir o teclado no campo texto
        texto.becomeFirstResponder()
        texto.text = ""
    }

    @IBAction func salvarAnotacao(_ sender: Any) {
        salvar()
        
        //voltar para página inicial
        navigationController?.popToRootViewController(animated: true)
    }
    
    fileprivate func salvar() {
        let anotacao = NSEntityDescription.insertNewObject(forEntityName: "Anotacao", into: contextManager)
        
        anotacao.setValue(texto.text, forKey: "texto")
        anotacao.setValue(Date(), forKey: "data")
        
        do {
            try contextManager.save()
            print("Anotação salva com sucesso.")
        } catch let error as NSError {
            print("Erro ao salvar anotação: \(error.description)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

