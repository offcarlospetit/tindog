//
//  HomeViewController.swift
//  Tindog
//
//  Created by Carlos Petit on 09-05-18.
//  Copyright © 2018 Carlos Petit. All rights reserved.
//

import UIKit
import RevealingSplashView

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
        
        let leftBtn = UIButton(type: .custom)
        leftBtn.setImage(UIImage(named: "login"), for: .normal)
        leftBtn.imageView?.contentMode = .scaleAspectFit
        leftBtn.addTarget(self, action: #selector(goToLogin(sender:)), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem(customView: leftBtn)
        
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        // Do any additional setup after loading the view.
    }
    
    @objc func goToLogin(sender: UIButton){
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginViewControoler = storyBoard.instantiateViewController(withIdentifier: "LoginVC")
        present(loginViewControoler, animated: true, completion: nil)
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
