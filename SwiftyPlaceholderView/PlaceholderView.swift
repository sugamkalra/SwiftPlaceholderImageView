//
//  PlaceholderView.swift
//  SwiftyPlaceholderView
//
//  Created by Sugam Kalra on 17/12/15.
//  Copyright © 2015 Sugam Kalra. All rights reserved.
//

import UIKit

/**
 * PlaceholderView
 * Placeholder view used when no data or network failure
 *
 * @author Sugam
 * @version 1.0
 */
class PlaceholderView: UIView {
    
    /// the parent view
    var parentView: UIView!
    
    /// the image view
    var imageView: UIImageView!
    
    /// the message label
    var messageLabel: UILabel!
    
    /// the container view
    var containerView: UIView!
    
    /// tap handler
    var tapHandler: (() -> Void)?

    /// whether it's shown or not
    var shown: Bool = false
    
    /**
     Initialization
     
     - Parameters:
        - parentView: the parent view
        - message: the message
        - image: the image shown above the message
        - tapHandler: the handler when the placeholder tapped
     */
    init(_ parentView: UIView, message: String, image: UIImage? = nil, tapHandler: (() -> Void)? = nil) {

        super.init(frame: parentView.bounds)
        
        self.parentView = parentView
        self.tapHandler = tapHandler
        self.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        // tap recognizer
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "placeholderDidPress")
        self.addGestureRecognizer(tapRecognizer)
        
        // container view
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // image view
        imageView = UIImageView(image: image ?? UIImage(named: "mark"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)
        
        // message label
        messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.font = UIFont.systemFontOfSize(15)
        messageLabel.textColor = UIColor.lightGrayColor()
        messageLabel.textAlignment = .Center
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .ByWordWrapping
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(messageLabel)
        
        self.addSubview(containerView)
        
        // binding views
        let views = ["messageLabel": messageLabel, "imageView": imageView, "containerView": containerView]
        var constraints = [NSLayoutConstraint]()
        
        // image view constraints
        constraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(>=0)-[imageView]-(>=0)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        // horizontally center the image
        constraints.append(NSLayoutConstraint(item: imageView, attribute: .CenterX, relatedBy: .Equal, toItem: containerView, attribute: .CenterX, multiplier: 1.0, constant: 0))
        // aligned with the top of the container
        constraints.append(NSLayoutConstraint(item: imageView, attribute: .Top, relatedBy: .Equal, toItem: containerView, attribute: .Top, multiplier: 1.0, constant: 0))
        
        // message label constraints
        constraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(10)-[messageLabel]-(10)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        constraints.append(NSLayoutConstraint(item: messageLabel, attribute: .Top, relatedBy: .Equal, toItem: imageView, attribute: .Bottom, multiplier: 1.0, constant: 15))
        containerView.addConstraints(constraints)
        
        // container view constraints
        constraints = [NSLayoutConstraint]()
        constraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:|[containerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        constraints.append(NSLayoutConstraint(item: containerView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0))
        constraints.append(NSLayoutConstraint(item: containerView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 0.3, constant: 0))
        self.addConstraints(constraints)

    }

    /// required, no need to implement
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Placholder did press action
     */
    func placeholderDidPress() {
        if self.tapHandler != nil {
            self.removed()
            self.tapHandler!()
        }
    }
    
    /**
     Show Placeholder view
     */
    func show() {
        if self.superview == nil {
            self.shown = true
            parentView.addSubview(self)
        }
    }
    
    /**
     Remove from Placeholder view
     */
    func removed() {
        self.shown = false
        self.removeFromSuperview()
    }
}
