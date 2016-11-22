//
//  LoginViewController.swift
//  TennisRSSFeedApp
//
//  Created by admin on 10/19/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnPassword: UIButton!
    
    
    @IBAction func OnClickedBtnLogin(_ sender: AnyObject) {
        if ((txtEmail.text?.isEmpty) == nil) {
            return
        }
        if ((txtPassword.text?.isEmpty) == nil) {
            return
        }
        
        
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "mainview") as UIViewController
        self.present(viewController, animated: true, completion: nil)

    }
    
    func LoadUI() {
        
        self.view.backgroundColor = UIColor(red: 82/255.0, green: 214/255.0, blue: 129/255.0, alpha: 1.0)
        
        btnEmail.backgroundColor = UIColor.clear
        btnEmail.layer.cornerRadius = 24
        btnEmail.layer.borderWidth = 2.0
        btnEmail.layer.borderColor = UIColor.white.cgColor
        
        btnPassword.backgroundColor = UIColor.clear
        btnPassword.layer.cornerRadius = 24
        btnPassword.layer.borderWidth = 2.0
        btnPassword.layer.borderColor = UIColor.white.cgColor
//
//        Btnleft.backgroundColor = UIColor.clearColor()
//        //BtnLogin.layer.cornerRadius = 5
//        Btnleft.layer.borderWidth = 0.5
//        Btnleft.layer.borderColor = UIColor.whiteColor().CGColor
//        
//        BtnLogin.backgroundColor = UIColor.clearColor()
//        BtnLogin.layer.cornerRadius = 5
//        BtnLogin.layer.borderWidth = 0.5
//        BtnLogin.layer.borderColor = UIColor.whiteColor().CGColor
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadUI()
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
