//
//  ThirdViewController.swift
//  tabb
//
//  Created by Mac16 on 6/3/15.
//  Copyright (c) 2015 iLab. All rights reserved.
//

import UIKit

class myLogin: UIViewController, NSURLConnectionDataDelegate {
    
    @IBOutlet weak var usuario: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var receivedData: NSMutableData!
    
    @IBAction func createDB(sender: AnyObject) {
        
        let url:NSURL = NSURL(string: "http://routemaps.itisol.com.mx/login.php")!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let bodyData = "username=\(usuario.text)&password=\(password.text)"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        //let conn: NSURLConnection = NSURLConnection(request: request, delegate: self)!
        let conn: NSURLConnection = NSURLConnection(request: request, delegate: self)!
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        receivedData.length=0
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        receivedData.appendData(data)
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        NSLog("ERROR: \(error.localizedDescription): \(error.userInfo)")
        
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        //let str: NSString = NSString(data:receivedData, encoding: NSASCIIStringEncoding)!
        var bienvenida = ""
        var jsonError: NSError?
        let jsonObject: AnyObject?
        do {
            jsonObject = try NSJSONSerialization.JSONObjectWithData(receivedData, options: [])
        } catch let error as NSError {
            jsonError = error
            print(jsonError)
            jsonObject = nil
        }
        
        if let usuario = jsonObject as? NSDictionary{
            print(usuario)
            let persona = usuario.objectForKey("nombre") as! String
            
            print(persona)
            bienvenida = persona
            
        }
        
        let pass = password.text
        
        if bienvenida != "" && pass != "" {
            performSegueWithIdentifier("toHomeScreen", sender: nil)
            
            let alert = UIAlertView()
            alert.title = "Bienvenido"
            //alert.message = bienvenida    DUDAAA
            alert.message = usuario.text
            alert.addButtonWithTitle("OK")
            alert.show()
        }
        else {
            let alert = UIAlertView()
            alert.title = "Validacion incorrecta"
            alert.message = "Revise su usuario y/o password"
            alert.addButtonWithTitle("OK")
            alert.show()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receivedData = NSMutableData(capacity: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
