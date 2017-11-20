//
//  VCMonuments.swift
//  ZamTour
//
//  Created by Manuel Blanco Suaña on 13/11/17.
//  Copyright © 2017 Taysir Al-Shareef Pinero. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class VCMonuments: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tbMiTable:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Mediante el DataHolder se dice que se observe la raíz "Perros" del FireBase y al
        //estar el código en la función viewDidLoad() entonces se ejecutará siempre que carguemos
        // la tabla de la app. De este modo nos devuelve los datos de la rama coches en forma de array.
        //observeSingleEvent se usa para que no cargue siempre la lista de datos y no gastar en exceso la tarifa
        // plana del usuario
        DataHolder.sharedInstance.firDataBaseRef.child("Monumentos").observeSingleEvent(of: .value, with: {(snapshot)
            in
            // Con el método observeSingleEvent lo que hacemos es evitar que se produzcan duplicados ya que con "obseve"
            // si se producen. El inconveniente es que no se actualizaría en tiempo real los cambios de la base de datos
            // y habría que volver a cargar la aplicación.
            
            let arrayMonum=snapshot.value as? Array<AnyObject>
            
            DataHolder.sharedInstance.arMonum=Array<Monuments>()
            // Este for se encargará de ir recorriendo el arTemp y sacando los datos del FireBase para que se
            // guarden en otro ArrayList (perroi) y se vayan mostrando
            for monumento in arrayMonum! as [AnyObject]{
                let monumi=Monuments(valores: monumento as! [String:AnyObject])
                DataHolder.sharedInstance.arMonum?.append(monumi)

                print(monumi)
            }
            

            self.tbMiTable?.reloadData()
            
        })
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if(DataHolder.sharedInstance.arMonum==nil){
            return 0
        }else{
            let numMonum=DataHolder.sharedInstance.arMonum?.count;
            DataHolder.sharedInstance.numMonum=numMonum;
            print("DataHolder.sharedInstance.numMonum");
            
            return  (DataHolder.sharedInstance.arMonum?.count)!
            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("xxxxxxxxxxxxx")
//        print(DataHolder.sharedInstance.uid)
//        print("xxxxxxxxxxxxx")
        let cell:TVCMonumentsCell = tableView.dequeueReusableCell(withIdentifier: "miCelda2")! as! TVCMonumentsCell
        
        // en la variable perroi, para cada posición del arrayList se irán sobrescribiendo con los nuevos
        //valores del perro.
        let monumi:Monuments=DataHolder.sharedInstance.arMonum![indexPath.row]
        cell.lblNombreMonumento?.text=monumi.sNombre
        cell.descargaImage(ruta: monumi.sImagen!)
        
        return cell
    }
    
 
    //Método que accede al contenido de cada perro al seleccionar una fila de la tabla es decir al seleccioanar una celda
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        DataHolder.sharedInstance.indexMonument=indexPath.row
//        print(DataHolder.sharedInstance.indexMonument!)
//        performSegue(withIdentifier: "trantable", sender: self)
//    }
//
//    @IBAction func btnVolver() {
//        DataHolder.sharedInstance.userEmail=""
//
//        try! Auth.auth().signOut()
//
//
//    }
//
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
