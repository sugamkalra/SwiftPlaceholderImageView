//
//  ViewController.swift
//  SwiftyPlaceholderView
//
//  Created by Sugam Kalra on 17/12/15.
//  Copyright © 2015 Sugam Kalra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // This is how to use placeholder view class - This image will provide the image in between when the original image is loading
        
        let imageView:UIImageView = UIImageView()
        
        let placeholder = PlaceholderView(imageView, message: NSLocalizedString("The file is not an image", comment: "Not an image message"))
        
        placeholder.show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

