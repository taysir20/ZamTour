//
//  ProfileCreate.swift
//  ZamTour
//
//  Created by Taysir Al-Shareef Pinero on 3/10/17.
//  Copyright © 2017 Taysir Al-Shareef Pinero. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseStorage
import FirebaseAuth

class ProfileCreate: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var btnRegister: UIButton!
    
    @IBOutlet weak var alias: UITextField!
    @IBOutlet weak var credits: UITextField!
    @IBOutlet weak var showCredits: UITextField!
    @IBOutlet weak var showEmail: UITextField!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnGallery: UIButton!
    @IBOutlet weak var btnExit: UIButton!
    @IBOutlet weak var viewContentImgProfile: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    
    var imgData:Data?
    let randNum = arc4random_uniform(1000000000)
    var rutaImg:String!
    let imgPicker = UIImagePickerController()
    let databaseRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgPicker.delegate=self
        credits.text="0"
        credits.isUserInteractionEnabled = false
        showEmail.text = DataHolder.sharedInstance.userEmail!// con ! desempaquetamos un optional
        showEmail.isUserInteractionEnabled = false
        viewContentImgProfile.layer.cornerRadius = (viewContentImgProfile?.frame.size.width)! / 2;
        viewContentImgProfile.layer.borderColor = UIColor.white.cgColor
        viewContentImgProfile.layer.borderWidth = 3.0;
        self.imgProfile.layer.cornerRadius = self.viewContentImgProfile.frame.width/2
        self.imgProfile.clipsToBounds = true
        self.imgProfile.layer.masksToBounds = true // ajusta el imgView al view
       
        
        btnExit.layer.borderWidth = 0
        btnRegister.backgroundColor = UIColor(red:0.33, green:0.67, blue:0.42, alpha:1.0)
        btnRegister.layer.cornerRadius = 2.5
        btnCamera.layer.cornerRadius = (btnCamera?.frame.size.width)! / 4;
        btnGallery.layer.cornerRadius = (btnGallery?.frame.size.width)! / 4;
        btnCamera.backgroundColor = UIColor.white
        btnGallery.backgroundColor = UIColor.white
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { // función con la que cambiamos el color del statusBar a blanco
        return .lightContent
    }
    
    @IBAction func abrirGaleria(_ sender: Any) {
        imgPicker.allowsEditing=false
        imgPicker.sourceType = .photoLibrary
        self.present(imgPicker, animated: true, completion: nil)
    }
    
    @IBAction func abrirCamara(_ sender: Any) {
        imgPicker.allowsEditing=false
        imgPicker.sourceType = .camera
        self.present(imgPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        imgData = UIImageJPEGRepresentation(img!, 0.1)! as Data
        imgProfile?.image = img
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func RandomInt(min: Int, max: Int) -> Int {
        if max < min { return min }
        return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
    }
    
    @IBAction func subirImg(_ sender: Any) {
        rutaImg=String(format:"Users/Profile/user%d.jpg", RandomInt(min: 0,max: Int(randNum)))
        let imgRefPerfil = DataHolder.sharedInstance.firStorageRef?.child(rutaImg)
        let uploadTaskPerfil = imgRefPerfil?.putData(imgData!, metadata:nil){ (metadata,error)
            in
            guard let metadata = metadata else{
                return
            }
            let downloadURL = metadata.downloadURL
        }
        
        let post : [String : Any] = ["PerfilIMG" : rutaImg,"Alias":  alias!.text!]
        databaseRef.child("Profile").child((DataHolder.sharedInstance.Usuario?.uid)!).setValue(post)
        self.performSegue(withIdentifier: "access", sender: self)
        
        
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
