//
//  LoginViewController.swift
//  ZamTour
//
//  Created by Taysir Al-Shareef Pinero on 29/9/17.
//  Copyright © 2017 Taysir Al-Shareef Pinero. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
class Login: UIViewController,UITextViewDelegate,UITextFieldDelegate, FBSDKLoginButtonDelegate{
    
    @IBOutlet weak var logo: UILabel!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblResultado: UILabel!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        lblResultado.text?=""
        let  loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.frame.origin = CGPoint(x: view.layer.frame.width/2 - loginButton.layer.frame.width/2, y: 415)
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.cornerRadius = 2.5
        loginButton.delegate=self
    }
    override var preferredStatusBarStyle: UIStatusBarStyle { // función con la que cambiamos el color del statusBar a blanco
        return .lightContent
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Has salido de Facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil{
            print(error)
            return
        }
        print("Loggin exitoso")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func btnSignIn(_ sender: Any) {
        signIn()
    }
    
    func signIn(){
        Auth.auth().signIn(withEmail: (self.txtEmail?.text)!, password: (self.txtPass?.text)!) {(user,error) in
            
            if(error==nil){
                self.lblResultado?.text = "¡Bienvenido!"
                let myColor = UIColor.white
                self.emailView.layer.borderColor = myColor.cgColor
                self.passView.layer.borderColor = myColor.cgColor
                self.emailView.layer.borderWidth = 1.0
                self.passView.layer.borderWidth = 1.0
                // delay para que se muestre por pantalla que se ha registrado correctamente antes de redirigirse
                // a la pantalla de "inicio de sesión" de nuevo.
                let when = DispatchTime.now() + 3
                DispatchQueue.main.asyncAfter(deadline: when){
                    
                    self.performSegue(withIdentifier: "signIn", sender: self)
                    
                }
                
                
            }else{
                print("Error en logueo", error!)
                self.lblResultado?.text=String(format: "Usuario o contraseña incorrectos ",(self.txtEmail?.text)!,(self.txtPass?.text)!)
                let myColor = UIColor.red
                self.emailView.layer.borderColor = myColor.cgColor
                self.passView.layer.borderColor = myColor.cgColor
                self.emailView.layer.borderWidth = 1.0
                self.passView.layer.borderWidth = 1.0
            }
        }
    }
    
}
