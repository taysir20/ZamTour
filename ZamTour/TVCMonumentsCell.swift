//
//  TVCMonumentsCell.swift
//  ZamTour
//
//  Created by Manuel Blanco Suaña on 13/11/17.
//  Copyright © 2017 Taysir Al-Shareef Pinero. All rights reserved.
//

import UIKit
import FirebaseStorage

class TVCMonumentsCell: UITableViewCell {
    
    @IBOutlet var lblNombreMonumento:UILabel?
    @IBOutlet var imgMonument: UIImageView?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lblNombreMonumento?.layer.cornerRadius=(lblNombreMonumento?.frame.size.width)!/9
        lblNombreMonumento?.clipsToBounds = true
        self.imgMonument?.layer.cornerRadius = (self.imgMonument?.frame.size.width)! / 4;
        self.imgMonument?.clipsToBounds = true
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func descargaImage(ruta:String){ // pasamos por parametro la ruta de las imagenes que se encuentran en el FireBase
        // Create a reference to the file you want to download
        let islandRef = DataHolder.sharedInstance.firStorageRef?.child(ruta)
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        islandRef?.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                // Uh-oh, an error occurred!
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                
                self.imgMonument?.image=image
            }
        }
        
    }
    
}
