//
//  MyLoginViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 15/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyLoginViewController: UIViewController
{
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var checkboxStayLoggedin: CheckboxHelper!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var inputEmail: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Inloggen"
        
        btnLogin.setTitle("Inloggen", for: .normal)
        btnLogin.setTitleColor(UIColor.white, for: .normal)
        btnLogin.backgroundColor = UIColor(rgb: 0xE84A4A)
        
        checkboxStayLoggedin.setTitle("Ingelogd blijven", for: .normal)
        checkboxStayLoggedin.setTitleColor(UIColor.black, for: .normal)
        
        btnForgotPassword.setTitle("Wachtwoord vergeten?", for: .normal)
        btnForgotPassword.setTitleColor(UIColor.black, for: .normal)
        
        inputEmail.placeholder = "Voer uw emailaders in"
        inputEmail.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputEmail.layer.borderWidth = 0
      
        inputPassword.placeholder = "Voer uw wachtwoord in"
        inputPassword.isSecureTextEntry = true
        inputPassword.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputPassword.layer.borderWidth = 0
    }
    
    @IBAction func btnLogin_OnClick(_ sender: Any)
    {
        
        self.performSegue(withIdentifier: "loginFinish", sender: self)
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //override func viewWillDisappear()
    //{
    //    super.viewWillDisappear()
    //    self.navigationController?.viewControllers.removeAll()
    //}
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
