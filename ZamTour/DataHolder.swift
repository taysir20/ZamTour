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
    //var ref: DatabaseReference! //Establecemos una variable de tipo DatabaseReference para luego llamar a las funciones del firebase que establecen una referencia  ala bbdd.
    var Usuario: User?
    var uid: String?
    var userEmail: String?
    var firDataBaseRef : DatabaseReference!
    var firStorage:Storage?
    var firStorageRef:StorageReference?
    var arOfers:Array<Ofer>?
    var arUrlMyOfers:Array<String>?
    var urlOfer:String?;
    var arMonum:Array<Monuments>?
    var urlMonum:String?
    var numMonum:Int?
    var indexMonument:Int?
    var countOfers:Int?=0;
    
    
    
    func initFireBase(){
        FirebaseApp.configure()//Método propio de firebase para poder conectarse a él.
        firDataBaseRef = Database.database().reference()// establecemos la referencia a la bbdd.
        firStorage = Storage.storage()
        firStorageRef=firStorage?.reference()
    }
}
