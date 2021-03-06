//
//  LoginViewController.swift
//  ZamTour
//
//  Created by Taysir Al-Shareef Pinero on 29/9/17.
//  Copyright © 2017 Taysir Al-Shareef Pinero. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
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
       /*
        //comprobación de logueo del usuario
      Auth.auth().addStateDidChangeListener { (auth, user) in
                     // ...
                    if(user != nil){
                        DataHolder.sharedInstance.firDataBaseRef.child("Profile").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: DataEventType.value, with:{ (snapshot) in
                            
                            DataHolder.sharedInstance.Usuario=user
                            let value = snapshot.value as? NSDictionary
                            DataHolder.sharedInstance.uid=(Auth.auth().currentUser?.uid)!
                            if(value == nil){
                                FBSDKGraphRequest(graphPath: "/me", parameters:["fields": "id, name, email"]).start { (connection, result, err) in
                                    if err != nil {
                                        print("Error en la muestra de los campos", err)
                                        return
                                    }
                                    print(result)
                                    let hashMap = result as! NSDictionary
                                    DataHolder.sharedInstance.userEmail = (hashMap["email"] as! String)
                                    print(DataHolder.sharedInstance.userEmail)
                                    self.performSegue(withIdentifier: "createProfile", sender: self)
                                    
                                    }
                               
                            }else{
                                self.performSegue(withIdentifier: "signIn", sender: self)
                            }
                            
                            
                        })
                        
                    }
                    else{
                        print("no está logueado")
                        }
 
            
            
                    }
        
    
        */
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
       
        UIApplication.shared.statusBarStyle = .lightContent
        lblResultado.text?=""
        let  loginButton = FBSDKLoginButton()//creacion de btn de facebook mediante una cte
        view.addSubview(loginButton) //añadimos el btn de facebook a la view para mostrarlo
        //Posicionamiento y estilo para el btn Facebook en la view
        loginButton.frame.origin = CGPoint(x: view.layer.frame.width/2 - loginButton.layer.frame.width/2, y: 415)
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.cornerRadius = 2.5
        loginButton.delegate=self
        loginButton.readPermissions = ["public_profile","email"] // damos permisos para poder obtener el email.
 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle { // función con la que cambiamos el color del statusBar a blanco
        return .lightContent
    }
    
    //Función de logout de Facebook
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Has salido de Facebook")
    }
    //Función que comprueba si el Login de Facebook se realizó correctamente
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil{
            print(error)
            return
        }
      
        print("Loggin exitoso")
        showEmailAdress()
    }
 
    
    //Método Sign In de Facebook
    
    func showEmailAdress(){
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else {
            return
        }
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        Auth.auth().signIn(with: credentials, completion: { (user, error) in
            if error != nil {
                print("Se ha producido un error relacionado con el usuario de Facebook: ", error)
                return
            }
              print("Enhorabuena has sido logueado con tu usuario de Facebook", user)
            self.lblResultado?.text = "¡Bienvenido!"
            let UserId = Auth.auth().currentUser?.uid
            DataHolder.sharedInstance.firDataBaseRef.child("Profile").child(UserId!).observeSingleEvent(of: DataEventType.value, with:{ (snapshot) in
                
                DataHolder.sharedInstance.Usuario=user
                let value = snapshot.value as? NSDictionary
                DataHolder.sharedInstance.uid=UserId
                if(value == nil){
                    FBSDKGraphRequest(graphPath: "/me", parameters:["fields": "id, name, email"]).start { (connection, result, err) in
                        if err != nil {
                            print("Error en la muestra de los campos", err)
                            return
                        }
                        print(result)
                        let hashMap = result as! NSDictionary
                        DataHolder.sharedInstance.userEmail = hashMap["email"] as! String
                    }
                    self.performSegue(withIdentifier: "createProfile", sender: self)
                    
                }else{
                    self.performSegue(withIdentifier: "signIn", sender: self)
                }
                
                
            })
            

        })
       
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
                    let UserId = Auth.auth().currentUser?.uid
                     DataHolder.sharedInstance.uid=(Auth.auth().currentUser?.uid)!
                    DataHolder.sharedInstance.firDataBaseRef.child("Profile").child(UserId!).observeSingleEvent(of: DataEventType.value, with:{ (snapshot) in
                        
                        DataHolder.sharedInstance.Usuario=user
                        let value = snapshot.value as? NSDictionary
                        DataHolder.sharedInstance.uid=UserId
                        if(value == nil){
                            self.performSegue(withIdentifier: "createProfile", sender: self)
                        }else{
                            self.performSegue(withIdentifier: "signIn", sender: self)
                        }
                        
                        
                    })
                   
                    
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
