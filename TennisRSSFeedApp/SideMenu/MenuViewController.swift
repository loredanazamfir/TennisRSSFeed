//
//  MenuViewController.swift
//  BOLD
//
//  Created by admin on 6/4/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func OnClickedBtnHome(_ sender: AnyObject) {
            hideSideMenuView()
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
