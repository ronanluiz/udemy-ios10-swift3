//
//  ViewController.swift
//  Onde Estou
//
//  Created by Ronan Luiz Araujo Eustaquio on 11/06/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    @IBOutlet weak var velocidadeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var enderecoLabel: UILabel!
    
    var gerenciadorLocalizacao = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // define que própria classe gerencie a localização
        gerenciadorLocalizacao.delegate = self
        // Define a precisão para definir a localização do usuário
        gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest
        // solicita autorização do usuário
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        // inicia o monitoramento da localização
        gerenciadorLocalizacao.startUpdatingLocation()
    }
    
    
    /// Executado durante a atualização de localizção do usuário
    ///
    /// - Parameters:
    ///   - manager:
    ///   - locations: Objeto com os dados de localização
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let localizacaoUsuario = locations.last!
        let latitute = localizacaoUsuario.coordinate.latitude
        let longitude = localizacaoUsuario.coordinate.longitude
        
        latitudeLabel.text = String(latitute)
        longitudeLabel.text = String(longitude)
        velocidadeLabel.text = String(localizacaoUsuario.speed)
    }
    
    
    /// Valida se o usuário alterou a configuração
    ///
    /// - Parameters:
    ///   - manager:
    ///   - status:
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status != .authorizedWhenInUse {
            
            let alertaController = UIAlertController(title: "Permissão de localização", message: "Necessário permissão para acesso à sua localização. Favor habilitar.", preferredStyle: .alert)
            
            let acaoConfiguracao = UIAlertAction(title: "Abrir configurações", style: .default, handler: { (alertaConfiguracoes) in
                
                if let configuracoes = NSURL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.open(configuracoes as URL)
                }
            })
            
            let acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            
            alertaController.addAction(acaoConfiguracao)
            alertaController.addAction(acaoCancelar)
            
            present(alertaController, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

