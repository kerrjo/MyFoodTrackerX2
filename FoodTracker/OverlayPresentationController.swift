//
//  OverlayPresentationController.swift
//  FoodTracker
//
//  Created by JOSEPH KERR on 4/6/16.
//  Copyright © 2016 JOSEPH KERR. All rights reserved.
//

import UIKit

class OverlayPresentationController: UIPresentationController {
    
    private var dimmingView : UIView?
    
    
    override init( presentedViewController: UIViewController, presentingViewController: UIViewController) {
        
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        
        prepareDimmingView()
    }
    
    
    override func presentationTransitionWillBegin() {
        
        // Here, we'll set ourselves up for the presentation
        
        guard let dv = dimmingView else {
            return
        }
        
        // Make sure the dimming view is the size of the container's bounds, and fully transparent

        dv.alpha = 0.0

        if let presentationContainerView = self.containerView {
            
            dv.frame = presentationContainerView.bounds

            // Insert the dimming view below everything else

            presentationContainerView.insertSubview(dv, atIndex: 0)
        }
        
      
        if let tc = presentedViewController.transitionCoordinator() {
            
            tc.animateAlongsideTransition({ (context: UIViewControllerTransitionCoordinatorContext) in
                
                dv.alpha = 1.0

                }, completion: nil)
            
        } else {
            
            dv.alpha = 1.0
        }
    }

    
    override func dismissalTransitionWillBegin() {
        // undo what we did in -presentationTransitionWillBegin. Fade the dimming view to be fully transparent

        guard let dv = dimmingView else {
            return
        }

        if let tc = presentedViewController.transitionCoordinator() {
            
            tc.animateAlongsideTransition({ (context: UIViewControllerTransitionCoordinatorContext) in
                
                dv.alpha = 0.0
                
                }, completion: nil)
            
        } else {
            
            dv.alpha = 0.0
        }
    }
    
    
    override func adaptivePresentationStyle() -> UIModalPresentationStyle {
        // When we adapt to a compact width environment, we want to be over full screen
        return .OverFullScreen;
    }

    
    // Helper
    
    func sizeForChildContentContainer(parentContainerSize: CGSize) -> CGSize {
        
        return CGSize(width: floor(parentContainerSize.width) / 2.2, height: parentContainerSize.height )
    }
    
    override func containerViewWillLayoutSubviews() {
    
        // Before layout, make sure our dimmingView and presentedView have the correct frame
        
        if let cv = self.containerView {
        
            self.dimmingView?.frame = cv.bounds
        }
        
        if let pv = self.presentedView() {
        
            pv.frame = frameOfPresentedViewInContainerView()
        }
    }
    
    override func shouldPresentInFullscreen() -> Bool {
        // This is a full screen presentation
        return true
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        
        // Return a rect with the same size as -sizeForChildContentContainer:withParentContainerSize:, and right aligned
        
        var presentedViewFrame = CGRectZero;

        if let cv = self.containerView {
            
            presentedViewFrame.size = sizeForChildContentContainer(cv.bounds.size)
            
            presentedViewFrame.origin.x = cv.bounds.size.width - presentedViewFrame.size.width;
        }
        
        return presentedViewFrame;
    }

    
    // MARK: dimming view init
    
    func prepareDimmingView() {
        
        let dv = UIView()
        
        dv.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.35)
        dv.alpha = 0.0
        
        let tapRec = UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped))
        
        dimmingView = dv
        
        dv.addGestureRecognizer(tapRec)
    }
    
    
    func dimmingViewTapped(gestureRec: UIGestureRecognizer) {
        
        if gestureRec.state == UIGestureRecognizerState.Recognized {
            self.presentingViewController .dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
}

