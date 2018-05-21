//
//  HomeViewController.swift
//  Tindog
//
//  Created by Carlos Petit on 09-05-18.
//  Copyright © 2018 Carlos Petit. All rights reserved.
//

import UIKit
import RevealingSplashView
import Firebase

class NavigationImageView : UIImageView{
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: 76, height: 39)
    }
}

class HomeViewController: UIViewController {

    //Outlets
    @IBOutlet weak var CardView: UIView!
    @IBOutlet weak var homeWrapper: UIStackView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var nope_image: UIImageView!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var labelNameHome: UILabel!
    
    let leftBtn = UIButton(type: .custom)
    let rigthBtn = UIButton(type: .custom)
    
    var currentUserProfile: UserModel?
    var currentMatch: MatchModel?
    var secondUserUID : String?
    
    
    //var currentMatch: MatchModel?
    var users = [UserModel]()
    
    let revealingSplashScreen = RevealingSplashView(iconImage: UIImage(named: "splash_icon")!, iconInitialSize: CGSize(width: 80, height: 80), backgroundColor: UIColor.white)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //carga de splash
        self.view.addSubview(self.revealingSplashScreen)
        self.revealingSplashScreen.animationType = SplashAnimationType.popAndZoomOut
        self.revealingSplashScreen.startAnimation()
        
        //set Icon navigation bar
        let titleView = NavigationImageView() //creo el objeto de tipo NavigationImageView() (clase que previaente sobreescribi)
        titleView.image = UIImage(named:"Actions") //le paso la imagen que quiero cargar en la barra al objeto que cree
        self.navigationItem.titleView = titleView // le asigno la imagen a la barra con el objeto titleVIew
        let homeGCR = UIPanGestureRecognizer(target: self, action: #selector(cardDragged(gestureRecognizer: )))
        self.CardView.addGestureRecognizer(homeGCR)
        /////
        
        self.leftBtn.setImage(UIImage(named: "login"), for: .normal)
        self.leftBtn.imageView?.contentMode = .scaleAspectFit
        let leftBarButton = UIBarButtonItem(customView: self.leftBtn)
        
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.rigthBtn.setImage(UIImage(named: "match_inactive"), for: .normal)
        self.rigthBtn.imageView?.contentMode = .scaleAspectFit
        let rigtBarButton = UIBarButtonItem(customView: self.rigthBtn)
        
        self.navigationItem.rightBarButtonItem = rigtBarButton
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                print(user)
            }else
            {
                print("logout")
            }
            
            DataBaseService.instans.observeUserProfile { (userDict) in
                self.currentUserProfile = userDict
                UpdateDBService.instance.observerMatch {(matchDict) in
                    if let match = matchDict{
                        //usuario 2 match.uid2
                        if let user = self.currentUserProfile{
                            if user.userIsOnMatch == false {
                                self.currentMatch = match
                                self.rigthButtonBtn(active: true)
                            }
                        }
                    }else{
                        self.rigthButtonBtn(active: false)
                    }
                }
            }
            
            self.getUsers()
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil{
            self.leftBtn.setImage(UIImage(named: "login_active"), for: .normal)
            self.leftBtn.removeTarget (nil, action: nil, for: .allEvents)
            self.leftBtn.addTarget(self, action: #selector(goToProfiles(sender:)), for: .touchUpInside)
        }else{
            self.leftBtn.setImage(UIImage(named: "login"), for: .normal)
            self.leftBtn.removeTarget (nil, action: nil, for: .allEvents)
            self.leftBtn.addTarget(self, action: #selector(goToLogin(sender:)), for: .touchUpInside)
        }
    }
    
    @objc func goToProfiles(sender: UIButton){
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let profileViewControoler = storyBoard.instantiateViewController(withIdentifier: "PerfilVC") as! PerfilViewController
        profileViewControoler.currentUserProfile = self.currentUserProfile
        self.navigationController?.pushViewController(profileViewControoler, animated: true)
    }
    
    @objc func goToLogin(sender: UIButton){
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginViewControoler = storyBoard.instantiateViewController(withIdentifier: "LoginVC")
        present(loginViewControoler, animated: true, completion: nil)
    }
    
    @objc func goMatch(sender: UIButton){
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let MatchViewControoler = storyBoard.instantiateViewController(withIdentifier: "MatchVC") as! MatchViewController
        MatchViewControoler.currentUserProfile = self.currentUserProfile
        MatchViewControoler.curentMatch = self.currentMatch
        present(MatchViewControoler, animated: true, completion: nil)
    }
    
    func getUsers(){
        DataBaseService.instans.user_ref.observeSingleEvent(of: .value){(snapshot) in
            let userSnapshot = snapshot.children.compactMap{UserModel(snapshot: $0 as! DataSnapshot)}
            for user in userSnapshot{
                print("user \(user.displayName)")
                if self.currentUserProfile?.uid != user.uid{
                    self.users.append(user)
                }
                
            }
            if self.users.count > 0{
                self.updateImage(uid: (self.users.first?.uid)!)
            }
        }
        
    }
    
    func rigthButtonBtn(active: Bool) {
        if active{
            self.rigthBtn.setImage(UIImage(named: "match_active"), for: .normal)
            self.rigthBtn.removeTarget (nil, action: nil, for: .allEvents)
            self.rigthBtn.addTarget(self, action: #selector(goMatch(sender:)), for: .touchUpInside)
        }
        else{
            self.rigthBtn.removeTarget (nil, action: nil, for: .allEvents)
            self.rigthBtn.setImage(UIImage(named: "match_inactive"), for: .normal)
        }
    }
    
    func updateImage(uid: String){
        DataBaseService.instans.user_ref.child(uid).observeSingleEvent(of: .value){ (snapshot) in
            print(snapshot)
            if let userPRofile = UserModel(snapshot: snapshot){
                self.secondUserUID = userPRofile.uid
                self.cardImage.sd_setImage(with: URL(string: (userPRofile.profileImage)), completed: nil)
                self.labelNameHome.text = userPRofile.displayName
                self.secondUserUID = userPRofile.uid
            }
        }
        
    }
    
    
    
    @objc func cardDragged(gestureRecognizer: UIPanGestureRecognizer){
        //print("drag \(gesturerecognized.translation(in: view))")
        let CardPoint = gestureRecognizer.translation(in: view)
        self.CardView.center = CGPoint(x: self.view.bounds.width / 2 + CardPoint.x , y: self.view.bounds.height / 2 + CardPoint.y)
        
        let xFromCenter = self.view.bounds.width / 2 - self.CardView.center.x
        var rotate = CGAffineTransform(rotationAngle: xFromCenter / 200)
        let scale = min(100 / abs(xFromCenter), 1)
        var finalTransform = rotate.scaledBy(x: scale, y: scale)
        
        self.CardView.transform = finalTransform
        
        if self.CardView.center.x < (self.view.bounds.width / 2 - 100){
            self.nope_image.alpha = min(abs(xFromCenter) / 100, 1)
        }
        if self.CardView.center.x > (self.view.bounds.width / 2 + 100){
            self.likeImage.alpha = min(abs(xFromCenter) / 100, 1)
        }

        
        
        if gestureRecognizer.state == .ended{
            //print(self.CardView.center.x)
            if self.CardView.center.x < (self.view.bounds.width / 2 - 100){
                
            }
            if self.CardView.center.x > (self.view.bounds.width / 2 + 100){
                if let uid2 = self.secondUserUID{
                    DataBaseService.instans.createFireBaseMatch(uid: (self.currentUserProfile?.uid)!, uid2: uid2)
                }
                
            }
            
            //Update Image
            if self.users.count > 0{
                updateImage(uid: self.users[self.random(0..<self.users.count)].uid)
                
            }
            
            
            //reinicio
            rotate = CGAffineTransform(rotationAngle: 0)
            finalTransform  = rotate.scaledBy(x: 1, y: 1)
            self.CardView.transform = finalTransform
            self.likeImage.alpha = 0
            self.nope_image.alpha = 0
            
            self.CardView.center = CGPoint(x: self.homeWrapper.bounds.width / 2 , y: (self.homeWrapper.bounds.height / 2 - 30) )

            
        }
    }
    
    func random(_ range: Range<Int>)->Int{
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
