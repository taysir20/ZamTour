//
//  DataHolder.swift
//  ZamTour
//
//  Created by Taysir Al-Shareef Pinero on 29/9/17.
//  Copyright © 2017 Taysir Al-Shareef Pinero. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class DataHolder: NSObject {
    static let sharedInstance:DataHolder=DataHolder() //Cte que creamos para poder acceder a todos los métodos del DataHolder desde otras clases.
    var ref: DatabaseReference! //Establecemos una variable de tipo DatabaseReference para luego llamar a las funciones del firebase que establecen una referencia  ala bbdd.
    func initFireBase(){
        FirebaseApp.configure()//Método propio de firebase para poder conectarse a él.
        ref = Database.database().reference()// establecemos la referencia a la bbdd.
    }
}
