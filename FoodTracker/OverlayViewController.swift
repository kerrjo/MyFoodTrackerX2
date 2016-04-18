//
//  OverlayViewController.swift
//  FoodTracker
//
//  Created by JOSEPH KERR on 4/6/16.
//  Copyright © 2016 JOSEPH KERR. All rights reserved.
//

import UIKit

class OverlayViewController: UIViewController {

    
    var foregroundContentView : UIVisualEffectView
    var backgroundView : UIVisualEffectView
    var blurEffect : UIBlurEffect
    
    var label : UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        blurEffect = UIBlurEffect(style: .ExtraLight)
        foregroundContentView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blurEffect))
        backgroundView = UIVisualEffectView(effect: blurEffect)

        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?,
                 bundle nibBundleOrNil: NSBundle?) {

        blurEffect = UIBlurEffect(style: .ExtraLight)
        foregroundContentView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blurEffect))
        backgroundView = UIVisualEffectView(effect: blurEffect)

        super.init(nibName: nibNameOrNil,bundle: nibBundleOrNil)
        
        self.modalPresentationStyle = .Custom
    }
    
    func commonInit(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orangeColor()

        // Do any additional setup after loading the view.
        
        configureView()
    }
    
    
    func configureView() {
    
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        foregroundContentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backgroundView)
        self.view.addSubview(foregroundContentView)

        label = UILabel()
        label!.text = "Label ksdjlkdjf"
        label!.textColor = UIColor.blackColor()
        label!.backgroundColor = UIColor.lightGrayColor()

        label!.translatesAutoresizingMaskIntoConstraints = false
        
        foregroundContentView.contentView.addSubview(label!)
        
        // Layout
        
        let views: [String: AnyObject] = [
            "backgroundView" :  backgroundView,
            "foregroundContentView" : foregroundContentView,
            "label" : label!
        ]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[backgroundView]|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil, views: views))

        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[backgroundView]|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil, views: views))

        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[foregroundContentView]|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[foregroundContentView]|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil, views: views))

        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(50)-[label]",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(20)-[label]-(20)-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil, views: views))

//        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[label]-|",
//            options: NSLayoutFormatOptions(rawValue: 0),
//            metrics: nil, views: views))

        
        // Center
//        [NSLayoutConstraint constraintWithItem:view
//            attribute:NSLayoutAttributeCenterX
//            relatedBy:NSLayoutRelationEqual
//            toItem:view.superview
//            attribute:NSLayoutAttributeCenterX
//            multiplier:1.f constant:0.f];
//        
        self.view.layoutIfNeeded()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


//        NSDictionary* views = @{
//            @"backgroundView" : [self backgroundView],
//            @"foregroundContentView" : [self foregroundContentView],
//            @"label1" : [self hueLabel],
//            @"hueSlider" : [self hueSlider],
//            @"saturationLabel" : [self saturationLabel],
//            @"saturationSlider" : [self saturationSlider],
//            @"brightnessLabel" : [self brightnessLabel],
//            @"brightnessSlider" : [self brightnessSlider],
//            @"saveButton" : [self saveButton],
//            @"imageView" : [self imageView]
//        };


//        [[self view] addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[backgroundView]|" options:0 metrics:nil views:views]];
//        [[self view] addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backgroundView]|" options:0 metrics:nil views:views]];
//
//        [[self view] addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[foregroundContentScrollView]|" options:0 metrics:nil views:views]];
//        [[self view] addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[foregroundContentScrollView]|" options:0 metrics:nil views:views]];
//
//        [[self view] addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[foregroundContentView]|" options:0 metrics:nil views:views]];
//        [[self view] addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[foregroundContentView]|" options:0 metrics:nil views:views]];
//
//        [[self view] addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=30)-[hueLabel]-[hueSlider]-[saturationLabel]-[saturationSlider]-[brightnessLabel]-[brightnessSlider]-[saveButton]-(>=10)-[imageView(==200)]|" options:0 metrics:nil views:views]];
//

