//
//  ReporteInseguridadViewController.swift
//  tabb
//
//  Created by Daniel Reyes on 23/06/15.
//  Copyright (c) 2015 iLab. All rights reserved.
//

import UIKit

class ReporteInseguridadViewController: UIViewController {

    @IBOutlet weak var lugarAcontecimiento: UITextField!
    @IBOutlet weak var descripcion: UITextView!
    
    @IBAction func enviarReporte(sender: AnyObject) {
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //descripcion.backgroundColor = UIColor(red:1, green:0.49, blue:0.28, alpha:1)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
