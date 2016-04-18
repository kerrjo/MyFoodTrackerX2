//
//  OverlayTransitioner.swift
//  FoodTracker
//
//  Created by JOSEPH KERR on 4/6/16.
//  Copyright © 2016 JOSEPH KERR. All rights reserved.
//

import UIKit


class OverlayAnimatedTransitioning : NSObject, UIViewControllerAnimatedTransitioning {
    
    let isPresentation: Bool
    
    init(isPresenting: Bool){
        isPresentation = isPresenting
        super.init()
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {

        return 0.25;
    }

    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {

        animateTransition1(transitionContext)
        
//        animateTransition2(transitionContext)
    }
    
    
    func animateTransition1(transitionContext: UIViewControllerContextTransitioning) {
        
        print(#function)
        
        guard let containerView = transitionContext.containerView()
            else { return }

        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            let fromView = fromVC.view
            else { return }
        
        guard let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            let toView = toVC.view
            else { return }

        
        // We have have a FromV and a ToV and the ContainerV
        
        let animatingVC: UIViewController = isPresentation ? toVC : fromVC

        if isPresentation {
            containerView.addSubview(toView)
        }

        // Configure start and end frames for animatingView

        var initialFrame: CGRect
        var finalFrame: CGRect

        let appearedFrame = transitionContext.finalFrameForViewController(animatingVC)
        var dismissedFrame = appearedFrame
        
        // Dismissed frame is the same as appeared frame, but off the right edge of the container
        dismissedFrame.origin.x += dismissedFrame.size.width

        if isPresentation {
            initialFrame = dismissedFrame
            finalFrame = appearedFrame
        } else {
            initialFrame = appearedFrame
            finalFrame = dismissedFrame
        }

        
        // Animate the view
        
        let animatingView = animatingVC.view
        
        animatingView.frame = initialFrame
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0,usingSpringWithDamping: 3.68, initialSpringVelocity: 0.2, options: [.AllowUserInteraction, .BeginFromCurrentState], animations: {
            
            animatingView.frame = finalFrame
            
            }, completion: { (fini: Bool) in
                
                if !self.isPresentation {
                    // dismissing, remove the presented view from the hierarchy
                    fromView.removeFromSuperview()
                }
                
                transitionContext.completeTransition(true)
        })

    }

    
    
    func animateTransition2(transitionContext: UIViewControllerContextTransitioning) {
        
        print(#function)
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let fromView = fromVC?.view
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let toView = toVC?.view
        
        let containerView = transitionContext.containerView()
        
        var animatingVC: UIViewController
        
        if isPresentation {
            animatingVC = toVC!
            containerView?.addSubview(toView!)
        } else {
            animatingVC = fromVC!
        }
        
        var appearedFrame: CGRect
        var dismissedFrame: CGRect
        
        appearedFrame = transitionContext.finalFrameForViewController(animatingVC)
        
        // Our dismissed frame is the same as our appeared frame, but off the right edge of the container
        
        dismissedFrame = appearedFrame
        dismissedFrame.origin.x += dismissedFrame.size.width
        
        
        let animatingView = animatingVC.view
        
        var initialFrame: CGRect
        var finalFrame: CGRect
        
        if isPresentation {
            initialFrame = dismissedFrame
            finalFrame = appearedFrame
            
        } else {
            initialFrame = appearedFrame
            finalFrame = dismissedFrame
        }
        
        animatingView.frame = initialFrame
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0,usingSpringWithDamping: 3.68, initialSpringVelocity: 0.2, options: [.AllowUserInteraction, .BeginFromCurrentState], animations: {
            
            animatingView.frame = finalFrame
            
            },completion: { (fini: Bool) in
                if !self.isPresentation {
                    // If we're dismissing, remove the presented view from the hierarchy
                    fromView?.removeFromSuperview()
                }
                
                transitionContext.completeTransition(true)
        })
        
    }
    
}


// MARK: TransitioningDelegate

class OverlayTransitioningDelegate : NSObject, UIViewControllerTransitioningDelegate {
    
    // ios8
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        print(#function)
        
        let pcc = OverlayPresentationController(presentedViewController: presented, presentingViewController: presenting)
    
        return pcc
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        print(#function)
        let ac = OverlayAnimatedTransitioning(isPresenting: true)
        
        return ac
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        print(#function)
        let ac = OverlayAnimatedTransitioning(isPresenting: false)
        
        return ac
    }
    
}





// failed to obtain view  transitionContext.viewForKey
//
//        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
//            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
//            else {
//                return
//        }
//        guard let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
//            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
//            else {
//                return
//        }

