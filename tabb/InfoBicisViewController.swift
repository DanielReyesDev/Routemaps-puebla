//
//  InfoBicisViewController.swift
//  Routemaps
//
//  Created by Daniel Reyes Sánchez on 11/07/15.
//  Copyright (c) 2015 iLab. All rights reserved.
//

import UIKit

class InfoBicisViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenHeight = screenSize.height
        
        scrollView = UIScrollView(frame: view.bounds)
        

        //scrollView.contentSize.height = screenHeight
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
