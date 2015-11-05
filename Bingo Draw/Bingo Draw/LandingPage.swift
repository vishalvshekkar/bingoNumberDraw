//
//  LandingPage.swift
//  Bingo Draw
//
//  Created by Vishal V Shekkar on 06/11/15.
//  Copyright © 2015 Vishal V Shekkar. All rights reserved.
//

import UIKit

var minimumInt = 1
var maximumInt = 90

class LandingPage: UIViewController {

    @IBOutlet weak var minimumNumber: UITextField!
    @IBOutlet weak var maximumNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func proceedAction(sender: AnyObject) {
        var intCount = 0
        if let min = minimumNumber.text {
            if let minInt = Int(min) {
                minimumInt = minInt
                intCount++
            }
        }
        if let max = maximumNumber.text {
            if let maxInt = Int(max) {
                maximumInt = maxInt
                intCount++
            }
        }
        
        if intCount == 2 {
            let drawController = self.storyboard?.instantiateViewControllerWithIdentifier("drawView") as! ViewController
            self.navigationController?.pushViewController(drawController, animated: true)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}
