//
//  ThirdViewController.swift
//  App3
//
//  Created by Kipras on 2/18/16.
//  Copyright © 2016 Kipras. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.MadLibText.text = toPass
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Make another story, passes counter for random text
    // so the same random text would not be generated again
    @IBOutlet weak var MadLibText: UILabel!
    
    var toPass: String!
    var randomCounter: Int!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let randomKeeper = segue.destinationViewController as! SecondViewController;
        
        randomKeeper.previous = randomCounter

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
