//
//  LocalizacaoUsuarioViewController.swift
//  Trabalhando com Mapas
//
//  Created by Ronan Luiz Araujo Eustaquio on 07/06/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit
import MapKit

class LocalizacaoUsuarioViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocalizacao = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // define que o gerenciar é a própria classa
        gerenciadorLocalizacao.delegate = self
        // precisão desejada
        gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest
        // solicita autorização do usuário para compartilhar a localização
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        // inicia a atualização de localização do usuário
        gerenciadorLocalizacao.startUpdatingLocation()
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let localizacaoUsuario = locations.last!
        
        // monta a exibição no mapa
        let latitude: CLLocationDegrees = localizacaoUsuario.coordinate.latitude
        let longitude: CLLocationDegrees = localizacaoUsuario.coordinate.longitude
        
        // define a precisão de visualização do mapa. Quanto menor, mais preciso
        let deltaLatitude: CLLocationDegrees = 0.01
        let deltaLongitude: CLLocationDegrees = 0.01
        
        let localizacao = CLLocationCoordinate2DMake(latitude, longitude)
        let areaVisualicao = MKCoordinateSpanMake(deltaLatitude, deltaLongitude)
        let regiao = MKCoordinateRegionMake(localizacao, areaVisualicao)
        
        mapa.setRegion(regiao, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
