//
//  Ofer.swift
//  ZamTour
//
//  Created by Taysir Al-Shareef Pinero on 30/10/17.
//  Copyright © 2017 Taysir Al-Shareef Pinero. All rights reserved.
//

import UIKit


class Ofer: NSObject {
    
    var sNombre: String?
    var sUrl: String?
    
    override init(){
        super.init()
        sNombre=""
        sUrl=""
    }
    init(valores:[String:AnyObject]){
        sNombre=valores["Nombre"] as? String
        sUrl=valores["url"] as? String
        
    
        
            
            
        }
    
    func getDiccionary()->[String:AnyObject]{
        var hm:[String:AnyObject]=[:]
        hm["Nombre"]=sNombre! as AnyObject
         hm["url"]=sUrl! as AnyObject
        return hm
    }


}
