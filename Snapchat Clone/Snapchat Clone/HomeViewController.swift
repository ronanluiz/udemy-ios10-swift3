//
//  HomeViewController.swift
//  Snapchat Clone
//
//  Created by Ronan Luiz Araujo Eustaquio on 17/08/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    var handleAuth: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        validarLogin()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // ocultar barra de navegação
        navigationController?.setToolbarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    fileprivate func validarLogin() {
        let autenticacao = Auth.auth()
        handleAuth = autenticacao.addStateDidChangeListener { (autenticacao, usuario) in
            if let _ = usuario {
                self.performSegue(withIdentifier: "loginAutomaticoSegue", sender: nil)
            }
        }
    }
}
