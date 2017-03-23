//
//  ViewController.swift
//  ExpandingView
//
//  Created by Shawn Roller on 3/23/17.
//  Copyright © 2017 OffensivelyBad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum PopupStates {
        case visible, hidden
    }
    var popupState = PopupStates.hidden
    let popupDuration: Double = 0.1
    let smallScale:CGFloat = 0.0001
    let largeScale: CGFloat = 1
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var showScrollViewButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    func initialSetup() {
        
        //hide the popup view initially
        self.popupView.transform = CGAffineTransform(scaleX: self.smallScale, y: self.largeScale)
        self.popupView.isHidden = true
        
        self.popupView.layer.cornerRadius = 10
        self.popupView.clipsToBounds = true
        
    }

    @IBAction func scrollViewButtonTapped(_ sender: Any) {
        
        var scale: CGFloat
        
        switch self.popupState {
        case .visible:
            //prepare variables for animation
            scale = self.smallScale
            self.popupState = .hidden
            
            //set the new button title
            self.showScrollViewButton.setTitle("Show Popup", for: .normal)
        case .hidden:
            //prepare variables for animation
            scale = self.largeScale
            self.popupView.isHidden = false
            self.popupState = .visible
            
            //set the new button title
            self.showScrollViewButton.setTitle("Hide Popup", for: .normal)
        }
        
        UIView.animate(withDuration: self.popupDuration, animations: { 
            
            self.popupView.transform = CGAffineTransform(scaleX: scale, y: scale)
            
        }) { (complete) in
            
            if self.popupState == .hidden { self.popupView.isHidden = true }
            
        }
        
    }
    
}

