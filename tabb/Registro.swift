//
//  Registro.swift
//  tabb
//
//  Created by Daniel Reyes on 13/06/15.
//  Copyright (c) 2015 iLab. All rights reserved.
//

import UIKit

class Registro: UIViewController, NSURLConnectionDataDelegate {
    
    
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var apellido: UITextField!
    @IBOutlet weak var usuario: UITextField!
    @IBOutlet weak var correo: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var receiveData: NSMutableData?

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    

    @IBAction func registrarse(sender: AnyObject) {
        
        
        
        if nombre.text == "" || apellido.text == "" || usuario.text == "" || correo.text == "" || password.text == ""{
            print("Error")
            let alert = UIAlertView()
            alert.title = "Registro incorrecto"
            alert.message = "Faltan datos"
            alert.addButtonWithTitle("OK")
            alert.show()
        }
        else {
         
            
            let myUrl = NSURL(string: "http://routemaps.itisol.com.mx/signin.php")
            let request = NSMutableURLRequest(URL:myUrl!)
            request.HTTPMethod = "POST"
            // Compose a query string
            let bd1 = "nombre=" + nombre.text!
            let bd2 = "&apellido=" + apellido.text!
            let bd3 = "&usuario=" + usuario.text!
            let bd4 = "&email=" + correo.text!
            let bd5 = "&contrasenia=" + password.text!
            let bodyData = bd1 + bd2 + bd3 + bd4 + bd5
            
            //let postString = "firstName=James&lastName=Bond";
            
            request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                
                if error != nil
                {
                    print("error=\(error)")
                    return
                }
                
                // You can print out response object
                print("response = \(response)")
                
                // Print out response body
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("responseString = \(responseString)")
                
                //Let’s convert response sent from a server side script to a NSDictionary object:
                do {
                    
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    print(json)
                    if let respuesta = json["respuesta"] as? Int {
                        print(respuesta)
                        
                        if respuesta == 1{
                            dispatch_async(dispatch_get_main_queue(), {
                                let alerta = UIAlertView()
                                alerta.title = "Registro Completado"
                                alerta.message = "Gracias"
                                alerta.addButtonWithTitle("OK")
                                alerta.show()
                            
                                self.performSegueWithIdentifier("toLogin", sender: self)
                            })
                        }else if respuesta == 0{
                            let alert = UIAlertView()
                            alert.title = "Error"
                            alert.message = "Ha ocurrido un error, vuelve a intentarlo"
                            alert.addButtonWithTitle("Aceptar")
                            alert.show()
                        }
                    
                    }
                    
                    
                    /*
                    
                    let myJSON = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                    
                    if let parseJSON = myJSON {
                        
                        // Now we can access value of First Name by its key
                        let firstNameValue = parseJSON["respuesta"] as? Int
                        
                        if firstNameValue == 1{
                            dispatch_async(dispatch_get_main_queue(), {
                                let alerta = UIAlertView()
                                alerta.title = "Registro Completado"
                                alerta.message = "Gracias"
                                alerta.addButtonWithTitle("OK")
                                alerta.show()
                                
                                self.performSegueWithIdentifier("toLogin", sender: self)
                            })
                            
                            
                        }
                        
                    }
                    */
                    
                    
                } catch {
                    print(error)
                }
                
                
                
                
                
            }
            
            task.resume()
        }
        
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 8.0, *)
    func dismissAlert(alert: UIAlertAction){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
