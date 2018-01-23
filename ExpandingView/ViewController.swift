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
    enum AnimationType {
        case zip, even
    }
    var animationType = AnimationType.even
    var popupState = PopupStates.hidden
    let popupDuration: Double = 0.5
    let smallScale:CGFloat = 0.0001
    let largeScale: CGFloat = 1
    let smallScaleDamping: CGFloat = 1
    let largeScaleDamping: CGFloat = 0.5
    var isAnimating = false
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var showScrollViewButton: UIButton!
    @IBOutlet weak var zipButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    func initialSetup() {
        
        //hide the popup view initially
        self.popupView.transform = CGAffineTransform(scaleX: self.smallScale, y: self.smallScale)
        self.popupView.isHidden = true
        
        self.popupView.layer.cornerRadius = 10
        self.popupView.clipsToBounds = true
        
    }
    
    @IBAction func toggleAnimationMode(_ sender: Any) {
        
        var xScale = self.smallScale
        switch self.animationType {
        case .even:
            self.animationType = .zip
            self.zipButton.setTitle("Zip", for: .normal)
            xScale = self.largeScale
        case .zip:
            self.animationType = .even
            self.zipButton.setTitle("Shrink", for: .normal)
            xScale = self.popupState == .hidden ? self.smallScale : self.largeScale
        }
        
        self.popupView.transform = CGAffineTransform(scaleX: xScale, y: self.popupView.transform.d)
    }

    @IBAction func scrollViewButtonTapped(_ sender: Any) {
        
        guard !self.isAnimating else { return }
        
        var scale: CGFloat
        var xScale = self.animationType == .even ? self.smallScale : self.largeScale
        var damping: CGFloat
        
        switch self.popupState {
        case .visible:
            //prepare variables for animation
            scale = self.smallScale
            self.popupState = .hidden
            damping = self.smallScaleDamping
            
            //set the new button title
            self.showScrollViewButton.setTitle("Show Popup", for: .normal)
        case .hidden:
            //prepare variables for animation
            scale = self.largeScale
            self.popupView.isHidden = false
            self.popupState = .visible
            damping = self.largeScaleDamping
            xScale = self.largeScale
            
            //set the new button title
            self.showScrollViewButton.setTitle("Hide Popup", for: .normal)
        }
        
        UIView.animate(withDuration: self.popupDuration, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: 0, options: .curveLinear, animations: {
            self.isAnimating = true
            self.popupView.transform = CGAffineTransform(scaleX: xScale, y: scale)
        }) { (_) in
            self.isAnimating = false
            if self.popupState == .hidden { self.popupView.isHidden = true }
        }
        
    }
    
}

