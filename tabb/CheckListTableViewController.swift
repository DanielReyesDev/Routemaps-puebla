//
//  CheckListTableViewController.swift
//  tabb
//
//  Created by Mac17 on 19/06/15.
//  Copyright (c) 2015 iLab. All rights reserved.
//

import UIKit

class CheckListTableViewController: UITableViewController {
    
    
    //var foodDictionary: NSMutableDictionary!
    var puntosInteres: NSArray!
    var puntosInteresSeleccionados: [NSString] = []

    
    @IBOutlet weak var doneOutlet: UIBarButtonItem!
    
    @IBAction func doneButton(sender: AnyObject) {
        
        performSegueWithIdentifier("toPuntosInteres", sender: self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("PuntosInteres", ofType: "plist")
        //foodDictionary = NSMutableDictionary(contentsOfFile: path!)
        //puntosInteres = NSArray(array: foodDictionary.keyEnumerator().allObjects)
        puntosInteres = NSArray(contentsOfFile: path!)
        
        
        
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        //doneButton.hidden = true
        //doneOutlet.enabled = false
        
        doneOutlet.enabled = false
        
        
        //self.navigationItem.rightBarButtonItem = doneOutlet
        //doneOutlet.
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //cuantas secciones tiene la tabla
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //cuantas filas tiene la tabla
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return puntosInteres.count
    }
    
    //se tiene que modificar en caso de que se quiera poner una celda personalizada
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CheckBoxCell", forIndexPath: indexPath) 
        
        let object = puntosInteres[indexPath.row] as! String
        cell.textLabel?.text = object
        
        return cell
    }
    
    
    //si seleccionan la tabla, mandamos a abrir la siguiente lista
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let mySelectedCell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        let stringCell = mySelectedCell.textLabel!.text!
        
        
        
        if (mySelectedCell.accessoryType == UITableViewCellAccessoryType.Checkmark) {
            mySelectedCell.accessoryType = UITableViewCellAccessoryType.None
            
            
            print(puntosInteresSeleccionados.count)
            
            if(puntosInteresSeleccionados.count == 1)
            {
                doneOutlet.enabled = false
            }
            
            
            for var i = 0 ; i < puntosInteresSeleccionados.count ; i++ {
                if puntosInteresSeleccionados[i] == stringCell {
                    puntosInteresSeleccionados.removeAtIndex(i)
                    break
                }
            }
        }
        else {
            mySelectedCell.accessoryType = UITableViewCellAccessoryType.Checkmark
            //self.navigationItem.rightBarButtonItem?.enabled = true
            //self.navigationItem.rightBarButtonItem = self
            //self.navigationItem.rightBarButtonItem = doneOutlet
            doneOutlet.enabled = true
            //.RightBarButtonItem =
            puntosInteresSeleccionados.append(stringCell)
        }
        
        
        
        print(puntosInteresSeleccionados)
        
        
        //performSegueWithIdentifier("toPuntosInteres", sender: self) TENEMOS QUE AGREGAR EL "DONE"
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toPuntosInteres" {
            
            (segue.destinationViewController as!
                PuntosInteresViewController).selectedCategories = puntosInteresSeleccionados
            
            /*  ESTE CODIGO SOLO ES DE EJEMPLO
            if let indexPath = tableView.indexPathForSelectedRow() {
            let object = puntosInteres[indexPath.row] as String
            (segue.destinationViewController as PuntosInteresViewController).selectedCategories = object
            
            }
            */
            
        }
    }
    
    
}