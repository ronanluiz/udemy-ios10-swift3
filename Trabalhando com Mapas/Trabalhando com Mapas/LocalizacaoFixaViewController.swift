//
//  ViewController.swift
//  Trabalhando com Mapas
//
//  Created by Ronan Luiz Araujo Eustaquio on 05/06/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit
import MapKit

class LocalizacaoFixaViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapa: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // -19.922936, -43.934053 - Parque Municipal
        let latitude: CLLocationDegrees = -19.922936
        let longitude: CLLocationDegrees = -43.934053
        
        // define a precisão de visualização do mapa. Quanto menor, mais preciso
        let deltaLatitude: CLLocationDegrees = 0.01
        let deltaLongitude: CLLocationDegrees = 0.01
        
        let localizacao = CLLocationCoordinate2DMake(latitude, longitude)
        let areaVisualicao = MKCoordinateSpanMake(deltaLatitude, deltaLongitude)
        let regiao = MKCoordinateRegionMake(localizacao, areaVisualicao)
        
        mapa.setRegion(regiao, animated: true)
        
        let anotacao = MKPointAnnotation()
        anotacao.coordinate = localizacao
        anotacao.title = "Parque Municipal Américo Renné Giannetti"
        anotacao.subtitle = "O Parque Municipal Américo Renné Giannetti foi projetado em estilo romântico inglês, pelo arquiteto paisagista francês, Paul Villon, para ser o maior e mais bonito parque urbano da América Latina."
        
        mapa.addAnnotation(anotacao)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

