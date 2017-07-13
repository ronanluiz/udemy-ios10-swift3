//
//  ViewController.swift
//  Minhas Viagens
//
//  Created by Ronan Luiz Araujo Eustaquio on 20/06/17.
//  Copyright © 2017 Rlz System. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapa: MKMapView!
    let gerenciadorLocalizacao = CLLocationManager()
    var indiceSelecionado: Int?
    var viagem: [String: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if indiceSelecionado != nil{
            exibirAnotacao(self.viagem)
        } else {
            setupLocationManager()
        }
        
        setupReconhecedorGestos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: MKMapViewDelegate {
    
    func setupReconhecedorGestos(){
        let reconhecdorGestos = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.marcarLocalizacao(gesture:)))
        reconhecdorGestos.minimumPressDuration = 2
        
        mapa.addGestureRecognizer(reconhecdorGestos)
        
    }
    
    func marcarLocalizacao(gesture: UIGestureRecognizer){
        if gesture.state == .began {
            
            // recupera as coordenadas do ponto selecionado
            let pontoSelecionado = gesture.location(in: self.mapa)
            let coordenadas = mapa.convert(pontoSelecionado, toCoordinateFrom: self.mapa)
            let localizacao = CLLocation(latitude: coordenadas.latitude, longitude: coordenadas.longitude)
            
            // recuperar endereço a partir das coordenadas
            var localCompleto = "Endereço não encont∫rado"
            CLGeocoder().reverseGeocodeLocation(localizacao, completionHandler: { (local, erro) in
                if erro == nil {
                    
                    if let dadosLocal = local?.first {
                        if let nomeLocal = dadosLocal.name {
                            localCompleto = nomeLocal
                        } else if let endereco = dadosLocal.thoroughfare {
                            localCompleto = endereco
                        }
                    }
                    
                    // salvar dados da viagem
                    self.viagem = [:]
                    self.viagem["local"] = localCompleto
                    self.viagem["latitude"] = String(coordenadas.latitude)
                    self.viagem["longitude"] = String(coordenadas.longitude)
                    RepositorioLocalViagem().salvar(self.viagem)
                    
                    self.exibirAnotacao(self.viagem)
                    
                } else {
                  print(erro!)
                }
            })
        }
    }
    
    func exibirAnotacao(_ viagem: [String: String]){
        
        if let latitudeViagem = viagem["latitude"],
            let longitudeViagem = viagem["longitude"],
            let localViagem = viagem["local"],
            let latitude = Double(latitudeViagem),
            let longitude = Double(longitudeViagem) {
            // exibe a anotação com dados do endereço
            let anotacao = MKPointAnnotation()
            
            anotacao.coordinate.latitude = latitude
            anotacao.coordinate.longitude = longitude
            anotacao.title = localViagem
            
            self.mapa.addAnnotation(anotacao)
            
            atualizaPosicaoMapa(latitude: latitude, longitude: longitude)
        }
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    
    
    func setupLocationManager(){
        
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status != .authorizedWhenInUse {
            
            let alertaController = UIAlertController(title: "Permissão de localização", message: "Necessário permissão para acesso à sua localização. Favor habilitar.", preferredStyle: .alert)
            
            let acaoConfiguracao = UIAlertAction(title: "Abrir configurações", style: .default, handler: { (alertaConfiguracoes) in
                
                self.abrirConfiguracoes()
            })
            
            let acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            
            alertaController.addAction(acaoConfiguracao)
            alertaController.addAction(acaoCancelar)
            
            present(alertaController, animated: true, completion: nil)
        }
        
    }
    
    func abrirConfiguracoes(){
        
        if let configuracoes = NSURL(string: UIApplicationOpenSettingsURLString) {
            UIApplication.shared.open(configuracoes as URL)
        }
    }
    
    func atualizaPosicaoMapa(latitude: Double, longitude: Double){
        
        let deltaLatitude = 0.01
        let deltaLongitude = 0.01
        
        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let areaExibicao: MKCoordinateSpan = MKCoordinateSpanMake(deltaLatitude, deltaLongitude)
        let regiao: MKCoordinateRegion = MKCoordinateRegionMake(localizacao, areaExibicao)
        
        mapa.setRegion(regiao, animated: true)
    }
    
    
    /// Recupera a localização do usuário
    ///
    /// - Parameters:
    ///   - manager: <#manager description#>
    ///   - locations: <#locations description#>
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let localUsuario = locations.last {
           atualizaPosicaoMapa(latitude: localUsuario.coordinate.latitude, longitude: localUsuario.coordinate.longitude)
        }
    }
    
}

