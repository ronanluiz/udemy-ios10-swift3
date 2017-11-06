//
//  FotoViewController.swift
//  Pods
//
//  Created by Ronan Luiz Araujo Eustaquio on 25/10/17.
//
//

import UIKit
import FirebaseStorage

class FotoViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let qualidadeImagem = CGFloat(0.5) // 50%
    let idImagem = NSUUID().uuidString
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var fotoImageView: UIImageView!
    @IBOutlet weak var descricaoText: UITextField!
    @IBOutlet weak var proximoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        desabilitarProximo()
    }
    
    @IBAction func selecionarFoto(_ sender: Any) {
        
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func executarProximo(_ sender: UIButton) {
        habilitarCarregando()
        let armazenamento = Storage.storage().reference()
        let imagensPasta = armazenamento.child("imagens")
        
        // Recupera a imagem 
        if let imagemSelecionada = fotoImageView.image,
           let imagemDados = UIImageJPEGRepresentation(imagemSelecionada, qualidadeImagem) {
            imagensPasta.child("\(idImagem).jpg").putData(imagemDados, metadata: nil, completion: { (metaDados, erro) in
                if erro == nil {
                    let url = metaDados?.downloadURL()?.absoluteURL
                    
                    self.performSegue(withIdentifier: "selecaoUsuarioSegue", sender: url)
                    
                } else {
                    let alerta = Alerta(titulo: "Upload", mensagem: "Erro ao realizar o upload das imagens.")
                    self.exibirMensagem(alerta: alerta)
                }
                
                self.desabilitarCarregando()
            })
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let imagemRecuperada = info[UIImagePickerControllerOriginalImage] as? UIImage {
            fotoImageView.image = imagemRecuperada
            habilitarProximo()
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func habilitarCarregando() {
        proximoButton.isEnabled = false
        proximoButton.setTitle("Carregando...", for: .normal)
    }
    
    fileprivate func desabilitarCarregando() {
        proximoButton.isEnabled = true
        proximoButton.setTitle("Próximo", for: .normal)
    }
    
    fileprivate func habilitarProximo() {
        proximoButton.isEnabled = true
        proximoButton.backgroundColor = UIColor(red: 0.553, green: 0.369, blue: 0.749, alpha: 1)
    }
    
    fileprivate func desabilitarProximo() {
        proximoButton.isEnabled = false
        proximoButton.backgroundColor = UIColor.gray
    }
    
}
