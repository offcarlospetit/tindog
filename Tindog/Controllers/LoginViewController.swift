//
//  LoginViewController.swift
//  Tindog
//
//  Created by Carlos Petit on 10-05-18.
//  Copyright © 2018 Carlos Petit. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextFile: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var loginCopyLabel: UILabel!
    @IBOutlet weak var subLoginBtn: UIButton!
    
    var registerMode = true
    
    @IBAction func subLoginActionBtn(_ sender: Any) {
        if self.registerMode{
            self.loginBtn.setTitle("Login", for: .normal)
            self.loginCopyLabel.text = "Eres Nuevo??"
            self.subLoginBtn.setTitle("Registrate", for: .normal)
            self.registerMode = false
        }
        else{
            self.loginBtn.setTitle("Crear Cuenta", for: .normal)
            self.loginCopyLabel.text = "Ya tienes cuenta?"
            self.subLoginBtn.setTitle("Login", for: .normal)
            self.registerMode = true
        }
    }
    
    func showAlerts(title: String, message: String){
        let alertView = UIAlertController(title: title , message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }
    
    @IBAction func loginActionBtn(_ sender: Any) {
        if self.emailTextFile.text == "" || self.passTextField.text == "" {
            self.showAlerts(title: "Error", message: "Alguno de los campos esta vacio")
        }
        else{
            if let email = self.emailTextFile.text{
                if let pass = self.passTextField.text{
                    if registerMode{
                        Auth.auth().createUser(withEmail: email, password: pass, completion: {(user, error) in
                            if error != nil {
                                self.showAlerts(title: "Error", message: (error?.localizedDescription)!)
                            }
                            else{
                                print("Cuenta Creada")
                                let userData = ["provider" : user?.providerID as Any, "email" : user?.email as Any, "profileImage": "https://scontent.fscl6-1.fna.fbcdn.net/v/t1.0-9/26047264_10215254347736707_4161256811649393988_n.jpg?_nc_cat=0&oh=98cd1edfe7507dd9abe967a68b6273a7&oe=5B867232", "displayName": "offcarlospetit" ] as [String: Any]
                                if let user = user{
                                    DataBaseService.instans.createFireBaseDBUser(uid: user.uid, userData: userData)
                                }
                            }
                        })
                    }else{
                        Auth.auth().signIn(withEmail: email, password: pass, completion: {(user, error) in
                            if error != nil {
                                self.showAlerts(title: "Error", message: (error?.localizedDescription)!)
                            }
                            else{
                                print("Login correcto")
                                self.dismiss(animated: true, completion: nil)
                            }
                        })
                    }
                }
            }
        }
    }
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bindKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
