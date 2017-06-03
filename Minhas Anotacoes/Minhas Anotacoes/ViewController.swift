//
//  ViewController.swift
//  Minhas Anotacoes
//
//  Created by Ronan Luiz Araujo Eustaquio on 02/06/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let chaveAnotacao = "chaveAnotacao"
    
    @IBOutlet weak var textoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textoTextView.text = obterDadosAnotacao()
    }

    @IBAction func salvarAnotacao(_ sender: UIButton) {
        desabilitarTeclado()
        if let texto = textoTextView.text {
            salvarDadosAnotacao(texto)
        }
    }
    
    func salvarDadosAnotacao(_ texto: String){
        UserDefaults.standard.set(texto,  forKey: chaveAnotacao)
    }
    
    func obterDadosAnotacao() -> String {
        let anotacao = UserDefaults.standard.object(forKey: chaveAnotacao)
        
        return anotacao != nil ? anotacao as! String : ""
    }
    
    func desabilitarTeclado(){
        view.endEditing(true)
    }
    /**
        Oculta barra de status
    */
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        desabilitarTeclado()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

