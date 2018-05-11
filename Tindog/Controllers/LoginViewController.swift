//
//  LoginViewController.swift
//  Tindog
//
//  Created by Carlos Petit on 10-05-18.
//  Copyright © 2018 Carlos Petit. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

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
