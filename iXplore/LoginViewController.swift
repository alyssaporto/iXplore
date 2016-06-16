//
//  LoginViewController.swift
//  iXplore
//
//  Created by Alyssa Porto on 6/14/16.
//  Copyright © 2016 Alyssa Porto. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var failureMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Log In"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        
        let email = emailField.text
        let password = passwordField.text
        let (failure, user) = UserController.sharedInstance.loginUser(email!, suppliedPassword: password!)
        if (user != nil) {
            print("User registered view registration view")
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToLoggedInNavigationController()
            failureMessage.text = ""
        } else {
            if (failure != nil) {
                failureMessage.text = failure
            }
        }

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
