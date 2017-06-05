//
//  TarefaViewController.swift
//  Lista de Tarefas
//
//  Created by Ronan Luiz Araujo Eustaquio on 02/06/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit

class TarefaViewController: UIViewController {
    
    @IBOutlet weak var tarefaTextView: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func adicionarTarefa(_ sender: UIButton) {
        if let tarefa = tarefaTextView.text {
            let tarefaBusiness = TarefaBusiness()
            tarefaBusiness.salvar(forTarefa: tarefa)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
