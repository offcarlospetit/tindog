//
//  HomeViewController.swift
//  Tindog
//
//  Created by Carlos Petit on 09-05-18.
//  Copyright © 2018 Carlos Petit. All rights reserved.
//

import UIKit

class NavigationImageView : UIImageView{
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: 76, height: 39)
    }
}

class HomeViewController: UIViewController {

    //Outlets
    @IBOutlet weak var CardView: UIView!
    @IBOutlet weak var homeWrapper: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set Icon navigation bar
        let titleView = NavigationImageView() //creo el objeto de tipo NavigationImageView() (clase que previaente sobreescribi)
        titleView.image = UIImage(named:"Actions") //le paso la imagen que quiero cargar en la barra al objeto que cree
        self.navigationItem.titleView = titleView // le asigno la imagen a la barra con el objeto titleVIew
        let homeGCR = UIPanGestureRecognizer(target: self, action: #selector(cardDragged(gesturerecognized: )))
        self.CardView.addGestureRecognizer(homeGCR)
        /////
        
        // Do any additional setup after loading the view.
    }
    
    @objc func cardDragged(gesturerecognized: UIPanGestureRecognizer){
        //print("drag \(gesturerecognized.translation(in: view))")
        let cardPoint = gesturerecognized.translation(in: view)
        self.CardView.center = CGPoint(x: self.view.bounds.width / 2 + cardPoint.x, y: self.view.bounds.height / 2 + cardPoint.y)
        
        if gesturerecognized.state == .ended{
            //print(self.CardView.center.x)
            if self.CardView.center.x < (self.view.bounds.width / 2 - 100){
                print("dislike")
            }
            if self.CardView.center.x > (self.view.bounds.width / 2 + 100){
                print("Like")
            }
            //reinicio
            self.CardView.center = CGPoint(x: self.homeWrapper.bounds.width / 2, y: (self.homeWrapper.bounds.height / 2 - 30) )
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
