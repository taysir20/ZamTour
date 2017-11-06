//
//  QRController.swift
//  ZamTour
//
//  Created by Taysir Al-Shareef Pinero on 10/10/17.
//  Copyright © 2017 Taysir Al-Shareef Pinero. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import FirebaseDatabase

class QRController: UIViewController, AVCaptureMetadataOutputObjectsDelegate{ // este delegate nos implementa los métodos para obtener cosas de la cámara

    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var viewMain: UIView!
    var captureSession: AVCaptureSession? // para usar la cámara hay que iniciar una sesión de cámara
    var videoPreviewLayer: AVCaptureVideoPreviewLayer? // creamos un preview Layer donde insertamos la view
    var qrCodeFrameView:UIView? //pintaremos un cuadrado alrededor de la zona donde esté detectando el QR
    var miOferta: Ofers?
    var blPausa:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //miOferta?.viewDidLoad()
        
        
        
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)// capturamos el vídeo
        do{
            
            let input = try AVCaptureDeviceInput(device:captureDevice) // le decimos que como entrada sea el captureDevice del vídeo
            //Ahora vamos a capturar los datos que recibimos por el input mediante el captureSession
            captureSession=AVCaptureSession() // iniciamos el captureSession
            captureSession?.addInput(input)//le asignamos el input
            ///Ahora tenemos que interpretar (traducir) lo que nos devuelve el input de la sesión de captura, para ello usamos
            //un metaDataCaptureOutput
            
            let captureMetaDataOutput = AVCaptureMetadataOutput() // creamos el captureMetaData
            captureSession?.addOutput(captureMetaDataOutput) // estamos diciendo la salida de los datos de la cámara
            
            //Una vez establevida la entrada y salida de los datos que recoge la cámara, vamos a asignarle su delegate
            captureMetaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetaDataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode] // le decimos el tipo de dato que queremos que nos detecte la cámara.En nuestro caso queremos que detecte el QR
            //Ahora hay que mostrar el previewLayer donde se va a mostrar la cámara e incluirlo en el viewMain
            
            //videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            //videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill // decimos que todo lo que pasa por la cámara lo muestre en tamaño con toda su totalidad
            //viewMain.layer.addSublayer(videoPreviewLayer!) // metemos el previewLayer en el ViewMain apra poder visualizar
            
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = viewMain.layer.bounds
            viewMain.layer.addSublayer(videoPreviewLayer!)
            
            captureSession?.startRunning() // iniciamos la sesión
            
            qrCodeFrameView = UIView() //vamos ahora a crear el recuadro verde que aparece cuando se detecta el QR
            
            if let qrCodeFrameView = qrCodeFrameView{
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubview(toFront: qrCodeFrameView)
            }
            
            
            
        }catch{
            
            print(error)
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // método que devuelve lo capturado por la cámara
    func captureOutput(_ output: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        //if(blPausa){
         //   return
        //}
        //print("HEY!!!!!!!!!")
        if (metadataObjects == nil || metadataObjects.count == 0){
            qrCodeFrameView?.frame = CGRect.zero // decimos que el tamaño sea 0 puesto que no recoje nada
            lblResult?.text = "No hay QR"
            return
            
        }
        print("HEY !!!!! ",metadataObjects.count)
        let metaDataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if metaDataObj.type == AVMetadataObjectTypeQRCode {
            
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metaDataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if(metaDataObj.stringValue != nil){
                
                lblResult?.text = metaDataObj.stringValue
                let text = metaDataObj.stringValue!
                //let text = "Ofertas/oferta1.jpg"
                print("--____>>>> ",text)
                
                DataHolder.sharedInstance.firDataBaseRef.child("Ofertas").queryOrdered(byChild: "url").queryStarting(atValue: text).queryEnding(atValue: text+"\u{f8ff}").observeSingleEvent(of: .value, with: {(snapshot)
                    in
                    /*let arTemp=snapshot.value as? Array<AnyObject>
                    DataHolder.sharedInstance.arOfers=Array<Ofer>()
                    for co in arTemp! as [AnyObject]{
                        let ofertai=Ofer(valores: co as! [String:AnyObject])
                        print(ofertai)
                        DataHolder.sharedInstance.arOfers?.append(ofertai)
                        
                    }*/
                    DataHolder.sharedInstance.urlOfer=text;
                    print("VALUE : ",snapshot.value!)
                    guard !snapshot.exists() else{
                        self.performSegue(withIdentifier: "viewOfer", sender: self)
                        return
                    }
                    
                    
                    
                    
                })
               
              
 
                
                // Do any additional setup after loading the view.
            
                
                 /* var i=0;
                for ofers in DataHolder.sharedInstance.arOfers! {
                    
                    let oferi:Ofer=DataHolder.sharedInstance.arOfers![i]
                    if(oferi.sUrl?.elementsEqual(metaDataObj.stringValue))!{
                        self.performSegue(withIdentifier: "viewOfer", sender: self)
                    }
                    i=i+1;
                    
                }
               */
 
                //blPausa=true
                
                //captureSession?.stopRunning()
                
                
                //CONSULTAR FIREBASE
                //SI FIREBASE NO ENCUENTRA:
                captureSession?.startRunning()
                //SI ENCUNTRA TRANSICION
                
            }
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

}
