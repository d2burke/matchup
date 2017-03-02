//
//  LoginViewController.swift
//  Matchup
//
//  Created by Daniel Burke on 3/1/17.
//  Copyright © 2017 Daniel Burke. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate {
    func didLogin()
}

class LoginViewController: UIViewController {

    var delegate: LoginViewControllerDelegate?
    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func login(_ sender: Any) {
        delegate?.didLogin()
    }


}
