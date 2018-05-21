//
//  MatchViewController.swift
//  Tindog
//
//  Created by Carlos Petit on 20-05-18.
//  Copyright © 2018 Carlos Petit. All rights reserved.
//

import UIKit
import Firebase

class MatchViewController: UIViewController {
    @IBOutlet weak var copyMatchLabel: UILabel!
    @IBOutlet weak var firtsUserMatch: UIImageView!
    @IBOutlet weak var secondUserMatch: UIImageView!
    @IBOutlet weak var dondeBtn: UIButton!
    
    var currentUserProfile: UserModel?
    var curentMatch: MatchModel?
    
    @IBAction func doneBtnAction(_ sender: Any) {
        if let currentMatch = self.curentMatch{
            if currentMatch.mathcIsAccepted{
                
            }else{
                DataBaseService.instans.updateFireBaseMatch(uid: currentMatch.uid)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.secondUserMatch.rounded()
        self.firtsUserMatch.rounded()
        self.dondeBtn.setTitle("Aceptar", for: .normal)
        
        if let match = self.curentMatch {
            if let profile = self.currentUserProfile{
                var secondid: String = ""
                if profile.uid == match.uid{
                    secondid = match.uid2
                }else{
                    secondid = match.uid
                }
                DataBaseService.instans.getUserProfile(uid: secondid, handler: {(secondUser) in
                    if let secondUser = secondUser{
                        if profile.uid == match.uid{
                            //init match
                            self.firtsUserMatch.sd_setImage(with: URL(string: profile.profileImage), completed: nil)
                            self.secondUserMatch.sd_setImage(with: URL(string: secondUser.profileImage), completed: nil)
                            self.copyMatchLabel.text = "Esperando a \(secondUser.displayName)"
                            self.dondeBtn.alpha = 0
                        }else{
                            //match
                            self.secondUserMatch.sd_setImage(with: URL(string: profile.profileImage), completed: nil)
                            self.firtsUserMatch.sd_setImage(with: URL(string: secondUser.profileImage), completed: nil)
                            self.copyMatchLabel.text = "\(secondUser.displayName) quiere contigo"
                            self.dondeBtn.alpha = 1
                        }
                        
                    }
                })
                
                
                
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
