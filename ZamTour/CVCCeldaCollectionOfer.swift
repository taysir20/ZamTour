


import UIKit
import FirebaseStorage

class CVCCeldaCollectionOfer: UICollectionViewCell {
    
    @IBOutlet var lblOferName:UILabel?
    @IBOutlet weak var imgOfer: UIImageView!
    
 
    
    func descargaImage(ruta:String){ // pasamos por parametro la ruta de las imagenes que se encuentran en el FireBase
        // Create a reference to the file you want to download
        let islandRef = DataHolder.sharedInstance.firStorageRef?.child(ruta) //esta ruta que se ha obtenido en el
        //DataHolder se almacena en la constante islandRef. De modo que si no hay ningún error al descargar su ruta
        //entonces se devuelve la imagen que se guarda en la variable imgMascota que es la variable ligada y conectada
        // con el UIImageView. Este proceso se repite para la colección.
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        islandRef?.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                // Uh-oh, an error occurred!
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                self.imgOfer?.image=image
            }
        }
    }
    
}


