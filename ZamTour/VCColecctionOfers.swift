import UIKit
import Firebase
import FirebaseDatabase

class VCColecctionOfers: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
   
    
    
    
    @IBOutlet weak var colPrincipal: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataHolder.sharedInstance.firDataBaseRef.child("Profile").child(DataHolder.sharedInstance.uid!).child("Descuentos").observeSingleEvent(of: DataEventType.value, with:{ (snapshot) in
            
            let arTemp=snapshot.value as? Array<String>
            
            DataHolder.sharedInstance.arUrlMyOfers=Array<String>()
            for co in arTemp!{
                DataHolder.sharedInstance.arUrlMyOfers?.append(co)
            }
            self.colPrincipal?.reloadData()
            
        })
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(DataHolder.sharedInstance.arUrlMyOfers==nil){
            return 0
        }else{
            return  (DataHolder.sharedInstance.arUrlMyOfers?.count)!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CVCCeldaCollectionOfer = collectionView.dequeueReusableCell(withReuseIdentifier: "cellMyOfer", for: indexPath) as! CVCCeldaCollectionOfer
        let oferi:String=DataHolder.sharedInstance.arUrlMyOfers![indexPath.row]
       // cell.lblNombreMascota?.text=perroi.sNombre
        cell.descargaImage(ruta: oferi)
        
        return cell
        
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


