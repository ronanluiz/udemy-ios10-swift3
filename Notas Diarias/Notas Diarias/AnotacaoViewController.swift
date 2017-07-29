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

    var gerenciadorContexto: NSManagedObjectContext!
    var anotacao: NSManagedObject!
    @IBOutlet weak var texto: UITextView!
    
    var temAnotacaoSelecionada: Bool {
        return anotacao != nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // inicializando contexto do core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        gerenciadorContexto = appDelegate.persistentContainer.viewContext
        
        // força abrir o teclado no campo texto
        texto.becomeFirstResponder()
        
        if temAnotacaoSelecionada {
            texto.text = anotacao.value(forKey: "texto") as? String
        } else {
            texto.text = ""
        }
    }

    @IBAction func salvarAnotacao(_ sender: Any) {
        if temAnotacaoSelecionada {
            atualizar()
        } else {
            salvar()
        }
        
        //voltar para página inicial
        navigationController?.popToRootViewController(animated: true)
    }
    
    fileprivate func salvar() {
        let anotacao = NSEntityDescription.insertNewObject(forEntityName: "Anotacao", into: gerenciadorContexto)
        
        anotacao.setValue(texto.text, forKey: "texto")
        anotacao.setValue(Date(), forKey: "data")
        
        do {
            try gerenciadorContexto.save()
            print("Anotação salva com sucesso.")
        } catch let error as NSError {
            print("Erro ao salvar anotação: \(error.description)")
        }
    }
    
    fileprivate func atualizar() {
        
        anotacao.setValue(texto.text, forKey: "texto")
        anotacao.setValue(Date(), forKey: "data")
        
        do {
            try gerenciadorContexto.save()
            print("Anotação atualizada com sucesso.")
        } catch let error as NSError {
            print("Erro ao atualizar anotação: \(error.description)")
        }
    }
}

