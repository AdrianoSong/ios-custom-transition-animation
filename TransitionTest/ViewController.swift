//
//  ViewController.swift
//  TransitionTest
//
//  Created by Adriano Song on 24/01/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var catImageView: UIImageView = {

        let view = UIImageView()
        view.image = UIImage(named: "cat")
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    let screenlabel: UILabel = {
        let view = UILabel()
        
        view.text = "main screen"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 20)
        view.textColor = .white
        view.backgroundColor = .blue
        
        return view
    }()
    
    let nextButton: UIButton = {
        
        let view = UIButton()
        view.setTitle("click to next", for: .normal)
        view.setTitleColor(.red, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Main controller"
        
        view.backgroundColor = .white
        
        view.addSubview(screenlabel)
        view.addSubview(nextButton)
        view.addSubview(catImageView)
        
        screenlabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        screenlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        screenlabel.isHidden = true
        
        catImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        catImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        catImageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        catImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //needs to conform everythime the delegate for apply custom animation
        navigationController?.delegate = self
    }
    
    @objc
    fileprivate func didTapButton() {
        let vc = DetailsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UINavigationControllerDelegate {
    
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
