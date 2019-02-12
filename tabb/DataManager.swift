//
//  DataManager.swift
//  tabb
//
//  Created by Daniel Reyes on 16/06/15.
//  Copyright (c) 2015 iLab. All rights reserved.
//

import Foundation

//let urlRutas = "{\"nombre\":\"reyes\",\"pass\":\"montero\"}" //hacerlo dinamico

class DataManager {
    
    class func getBienvenida(success: ((data: NSData) -> Void)) {
        //1
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            //2
            let filePath = NSBundle.mainBundle().pathForResource("TopApps",ofType:"json")
            
            var readError:NSError?
            do {
                let data = try NSData(contentsOfFile:filePath!,
                    options: NSDataReadingOptions.DataReadingUncached)
                    success(data: data)
            } catch let error as NSError {
                readError = error
            } catch {
                fatalError()
            }
        })
    }
    
    //class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSErr))
}
