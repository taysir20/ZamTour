//
//  Register.swift
//  ZamTour
//
//  Created by Taysir Al-Shareef Pinero on 29/9/17.
//  Copyright © 2017 Taysir Al-Shareef Pinero. All rights reserved.
//

import UIKit
import FirebaseAuth


class Register: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtEmailConfirm: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtPassConfirm: UITextField!
    @IBOutlet weak var btnTermsAndConditions: UIButton!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var sgAceptOrDecline: UISegmentedControl!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailConfirmView: UIView!
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var passConfirmView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblResult.text=""
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnTermsAndConditions(_ sender: Any) {
        viewTermsAndConditions()
    }
    
    func viewTermsAndConditions(){
        let cteTermsAndConditions = UIAlertController(title: "Términos y condiciones ", message: "Este Acuerdo gobierna su uso de los servicios de Apple ('Servicios') mediante los cuales puede comprar, obtener, licenciar, alquilar o subscribirse (cuando sea posible) a medios, aplicaciones ('Aplicaciones') y otros servicios (en conjunto 'Contenido'). Nuestros Servicios son: iTunes Store, App Store, iBooks Store, Apple Music y Apple News. Nuestros Servicios están disponibles para su uso en su país de residencia ('País de residencia'). Para usar nuestros Servicios, necesita hardware y software compatible (se recomienda tener la última versión y en algunos casos es necesario) y acceso a Internet (podrán aplicarse cargos). El rendimiento de nuestros servicios podrá verse afectado por estos factores.", preferredStyle: .actionSheet)
        
        let cteBtnTermsAndConditions = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        
        cteTermsAndConditions.addAction(cteBtnTermsAndConditions)
        
        present(cteTermsAndConditions, animated: true, completion: nil)
    }
    
    
    
    @IBAction func btnRegistro() {
        print("hola")
        let controlSegmento = sgAceptOrDecline.selectedSegmentIndex
        
        if(txtEmail?.text?.isEqual(txtEmailConfirm?.text))! && ((txtPass?.text)?.isEqual(txtPassConfirm?.text))!{
            if (controlSegmento == 0) {
                Auth.auth().createUser(withEmail: (txtEmail?.text)!, password: (txtPass?.text)!) {(user,error) in
                    Auth.auth().currentUser?.sendEmailVerification { (error) in
                        if(error==nil){
                            self.lblResult.text = "¡Enhorabuena!Ya está casi! Revisa tu bandeja de entrada."
                            let myColor2 = UIColor.white
                            self.passView.layer.borderColor = myColor2.cgColor
                            self.passConfirmView.layer.borderColor = myColor2.cgColor
                            self.passView.layer.borderWidth = 1.0
                            self.passConfirmView.layer.borderWidth = 1.0
                            self.emailView.layer.borderColor = myColor2.cgColor
                            self.emailConfirmView.layer.borderColor = myColor2.cgColor
                            self.emailView.layer.borderWidth = 1.0
                            self.emailConfirmView.layer.borderWidth = 1.0
                            self.btnTermsAndConditions.titleLabel?.textColor = UIColor.white
                            // delay para que se muestre por pantalla que se ha registrado correctamente antes de redirigirse
                            // a la pantalla de "inicio de sesión" de nuevo.
                            let when = DispatchTime.now() + 3
                            DispatchQueue.main.asyncAfter(deadline: when){
                                self.performSegue(withIdentifier: "register", sender: self)
                            }
                            
                        }else if((self.txtPass?.text?.characters.count)!<6){
                            self.lblResult.text = "La contraseña debe de contener al menos 6 caracteres"
                            let myColor = UIColor.red
                            let myColor2 = UIColor.white
                            self.passView.layer.borderColor = myColor.cgColor
                            self.passConfirmView.layer.borderColor = myColor.cgColor
                            self.passView.layer.borderWidth = 1.0
                            self.passConfirmView.layer.borderWidth = 1.0
                            self.emailView.layer.borderColor = myColor2.cgColor
                            self.emailConfirmView.layer.borderColor = myColor2.cgColor
                            self.emailView.layer.borderWidth = 1.0
                            self.emailConfirmView.layer.borderWidth = 1.0
                            self.btnTermsAndConditions.titleLabel?.textColor = UIColor.white
                            
                        }else{
                            self.lblResult.text = "Ya existe un usuario registrado con este nombre"
                            
                        }
                    }
                }
            }else if(controlSegmento == 1) {
                self.lblResult.text = "Debes aceptar los terminos y condiciones"
                let myColor = UIColor.red
                let myColor2 = UIColor.white
                self.passView.layer.borderColor = myColor2.cgColor
                self.passConfirmView.layer.borderColor = myColor2.cgColor
                self.passView.layer.borderWidth = 1.0
                self.passConfirmView.layer.borderWidth = 1.0
                self.emailView.layer.borderColor = myColor2.cgColor
                self.emailConfirmView.layer.borderColor = myColor2.cgColor
                self.emailView.layer.borderWidth = 1.0
                self.emailConfirmView.layer.borderWidth = 1.0
                self.btnTermsAndConditions.titleLabel?.textColor = UIColor.red
                
            }
        }else if (!(txtEmail?.text?.isEqual(txtEmailConfirm?.text))!) && ((txtPass?.text)?.isEqual(txtPassConfirm?.text))!{
            self.lblResult.text = "El email no coincide"
            let myColor = UIColor.red
            let myColor2 = UIColor.white
            self.emailView.layer.borderColor = myColor.cgColor
            self.emailConfirmView.layer.borderColor = myColor.cgColor
            self.emailView.layer.borderWidth = 1.0
            self.emailConfirmView.layer.borderWidth = 1.0
            self.passView.layer.borderColor = myColor2.cgColor
            self.passConfirmView.layer.borderColor = myColor2.cgColor
            self.passView.layer.borderWidth = 1.0
            self.passConfirmView.layer.borderWidth = 1.0
            self.btnTermsAndConditions.titleLabel?.textColor = UIColor.white
            
            
        }else{
            self.lblResult.text = "La contraseña no coincide"
            let myColor = UIColor.red
            let myColor2 = UIColor.white
            self.passView.layer.borderColor = myColor.cgColor
            self.passConfirmView.layer.borderColor = myColor.cgColor
            self.passView.layer.borderWidth = 1.0
            self.passConfirmView.layer.borderWidth = 1.0
            self.emailView.layer.borderColor = myColor2.cgColor
            self.emailConfirmView.layer.borderColor = myColor2.cgColor
            self.emailView.layer.borderWidth = 1.0
            self.emailConfirmView.layer.borderWidth = 1.0
            self.btnTermsAndConditions.titleLabel?.textColor = UIColor.white
        }
        
        
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
