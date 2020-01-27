//
//  FadePopAnimator.swift
//  TransitionTest
//
//  Created by Adriano Song on 24/01/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import UIKit

class FadePopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = transitionContext.viewController(forKey: .to) as? ViewController,
            let fromViewController = transitionContext.viewController(forKey: .from) as? DetailsViewController else {
                return
        }
        
        //animation needs to be performed here on containerView
        let containerView = transitionContext.containerView
        
        toViewController.view.layoutSubviews() //for update layout to get view frame
        toViewController.view.alpha = 0 //hide the pushed view controller
        
        //transition object (cat image)
        //we have to create a copy "snapshot" of view to prevent change the view itself by reference
        let catImageSnapshot = UIImageView(image: fromViewController.catImageView.image)
        containerView.addSubview(catImageSnapshot)
        
        //copy the frame from original image
        catImageSnapshot.frame = containerView.convert(
            fromViewController.catImageView.frame, to: fromViewController.catImageView.superview)
        
        // destination frame
        let destinationFrame = toViewController.catImageView.frame
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            toViewController.view.alpha = 1 //present the pushed view controller
            catImageSnapshot.frame = destinationFrame //apply change frame
            fromViewController.catImageView.isHidden = true //hide the original image
        }, completion: { _ in
            catImageSnapshot.removeFromSuperview() //remove "snapshot" image from container (optimization memory)
            containerView.addSubview(toViewController.view) //add the pushed view to container
            fromViewController.catImageView.isHidden = false //show the original image
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled) //complete custom transition
        })
    }
}
