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

class VCMonuments: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    @IBOutlet var tbMiTable:UITableView!
    @IBOutlet var searchBar: UISearchBar!
    var currentMonumentArray = Array<Monuments>()
    var monumentArray = Array<Monuments>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setUpSearchBar()
        alterLayout()
    
        DataHolder.sharedInstance.firDataBaseRef.child("Monumentos").observeSingleEvent(of: .value, with: {(snapshot)
            in
           
            
            let arrayMonum=snapshot.value as? Array<AnyObject>
            
            DataHolder.sharedInstance.arMonum=Array<Monuments>()
           
           
            for monumento in arrayMonum! as [AnyObject]{
                let monumi=Monuments(valores: monumento as! [String:AnyObject])
                DataHolder.sharedInstance.arMonum?.append(monumi)

                print(monumi)
            }
            
              self.monumentArray = DataHolder.sharedInstance.arMonum!
            self.tbMiTable?.reloadData()
            
        })
        
        // Do any additional setup after loading the view.
    }
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
 
    func alterLayout() {
        // search bar in section header
        tbMiTable.estimatedSectionHeaderHeight = 50
        // search bar in navigation bar
        //navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
        navigationItem.titleView = searchBar
        searchBar.showsScopeBar = false // you can show/hide this dependant on your layout
        searchBar.placeholder = "Monumento"
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
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        currentMonumentArray = monumentArray.filter({ monument -> Bool in
//            switch searchBar.selectedScopeButtonIndex {
//            case 0:
//                if searchText.isEmpty { return true }
//                return monument.sNombre!.lowercased().contains(searchText.lowercased())
//
//            default:
//                return false
//            }
//        })
//        tbMiTable.reloadData()
//
//    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      
        DataHolder.sharedInstance.arMonum! = (monumentArray.filter({ monumi -> Bool in
            switch searchBar.selectedScopeButtonIndex {
            case 0:
                if searchText.isEmpty { return true }
                return monumi.sNombre!.lowercased().contains(searchText.lowercased())
           
            default:
                return false
            }
        }))
        tbMiTable.reloadData()
    }
}
