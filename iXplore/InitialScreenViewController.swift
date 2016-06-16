//
//  InitialScreenViewController.swift
//  iXplore
//
//  Created by Alyssa Porto on 6/14/16.
//  Copyright © 2016 Alyssa Porto. All rights reserved.
//

import UIKit

class InitialScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Welcome"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        
        let loginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        self.navigationController?.pushViewController(loginViewController, animated: true)
        
    }

    @IBAction func registerButtonTapped(sender: AnyObject) {
     
        let registerViewController = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        self.navigationController?.pushViewController(registerViewController, animated: true)
        
    }

}
