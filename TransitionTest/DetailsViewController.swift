//
//  DetailsViewController.swift
//  TransitionTest
//
//  Created by Adriano Song on 24/01/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    var catImageView: UIImageView = {
        
        let view = UIImageView()
        view.image = UIImage(named: "cat")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let screenlabel: UILabel = {
        let view = UILabel()
        
        view.text = "detail screen"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 20)
        view.textColor = .white
        view.backgroundColor = .brown
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Details VC"
        
        view.backgroundColor = .white
        
        view.addSubview(screenlabel)
        
        screenlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        screenlabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        
        screenlabel.isHidden = true
        
        view.addSubview(catImageView)
        
        catImageView.topAnchor.constraint(equalTo: screenlabel.topAnchor).isActive = true
        catImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        catImageView.widthAnchor.constraint(equalToConstant: 180 / 2).isActive = true
        catImageView.heightAnchor.constraint(equalToConstant: 120 / 2).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //needs to conform everythime the delegate for apply custom animation
        self.navigationController?.delegate = self
    }
}

extension DetailsViewController: UINavigationControllerDelegate {
    
    //takes control of navigationController.push() or pop() to animate
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return FadePushAnimator()
        case .pop:
            return FadePopAnimator()
        default:
            return nil
        }
    }
}
