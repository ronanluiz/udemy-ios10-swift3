//
//  FotoViewController.swift
//  Pods
//
//  Created by Ronan Luiz Araujo Eustaquio on 25/10/17.
//
//

import UIKit

class FotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var fotoImageView: UIImageView!
    @IBOutlet weak var descricaoText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
    
    @IBAction func selecionarFoto(_ sender: Any) {
        
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let imagemRecuperada = info[UIImagePickerControllerOriginalImage] as? UIImage {
            fotoImageView.image = imagemRecuperada
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}
