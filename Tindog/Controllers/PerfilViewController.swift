//
//  PerfilViewController.swift
//  Tindog
//
//  Created by Carlos Petit on 13-05-18.
//  Copyright © 2018 Carlos Petit. All rights reserved.
//

import UIKit
import Firebase

class PerfilViewController: UIViewController {

    @IBOutlet weak var profileDisplayEmail: UILabel!
    @IBOutlet weak var profileDisplayName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBAction func closeProfile(_ sender: Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    



}
