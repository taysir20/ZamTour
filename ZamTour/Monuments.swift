//
//  Monuments.swift
//  ZamTour
//
//  Created by Manuel Blanco Suaña on 13/11/17.
//  Copyright © 2017 Taysir Al-Shareef Pinero. All rights reserved.
//

import UIKit

public class Monuments: NSObject {
    var sRutaColeccionMonumentos = [String]()
   public var sNombre: String?
    var sImagen: String?
    var sDescripccion: String?
    var dbLat: Double?
    var dbLon: Double?
    

override init(){
    super.init()
    sNombre=""
    sImagen=""
    sDescripccion=""
    dbLat=0
    dbLon=0

}
    init(valores:[String:AnyObject]){
        sNombre=valores["Nombre"] as? String
        sImagen=valores["MonumentoImg"] as? String
        sDescripccion=valores["Decripcion"] as? String
        dbLat=valores["lat"] as? Double
        dbLon=valores["long"] as? Double
        sRutaColeccionMonumentos=valores["coleccion"] as! [String]
        
    }
}
