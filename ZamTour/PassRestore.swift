//
//  PassRestore.swift
//  ZamTour
//
//  Created by Taysir Al-Shareef Pinero on 8/11/17.
//  Copyright © 2017 Taysir Al-Shareef Pinero. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class PassRestore: UIViewController {
    
    @IBOutlet weak var txtNotify: UILabel!
    @IBOutlet weak var sEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtNotify.text=""
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func botonRestablecerPass(){
        let email = sEmail?.text
        
        Auth.auth().sendPasswordReset(withEmail: email!) { error in
            if error != nil {
                self.txtNotify?.text="No existe ninguna cuenta asociada a este correo"
            } else {
                self.txtNotify?.text="Revisa la bandeja de entrada de tu correo electrónico."
            }
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

