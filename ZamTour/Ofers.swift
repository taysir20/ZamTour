//
//  Ofers.swift
//  ZamTour
//
//  Created by Taysir Al-Shareef Pinero on 30/10/17.
//  Copyright © 2017 Taysir Al-Shareef Pinero. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class Ofers: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataHolder.sharedInstance.firDataBaseRef.child("Ofertas").observeSingleEvent(of: .value, with: {(snapshot)
            in
            // Con el método observeSingleEvent lo que hacemos es evitar que se produzcan duplicados ya que con "obseve"
            // si se producen. El inconveniente es que no se actualizaría en tiempo real los cambios de la base de datos
            // y habría que volver a cargar la aplicación.
            let arTemp=snapshot.value as? Array<AnyObject>
            DataHolder.sharedInstance.arOfers=Array<Ofer>()
            // Este for se encargará de ir recorriendo el arTemp y sacando los datos del FireBase para que se
            // guarden en otro ArrayList (perroi) y se vayan mostrando
            for co in arTemp! as [AnyObject]{
                let ofertai=Ofer(valores: co as! [String:AnyObject])
                print(ofertai)
                DataHolder.sharedInstance.arOfers?.append(ofertai)
              
            }
            
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hola(){
        
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
