//
//  SocialViewController.swift
//  SportsApp
//
//  Created by Norhan on 4/24/21.
//  Copyright © 2021 Norhan. All rights reserved.
//

import UIKit
import WebKit

class SocialViewController: UIViewController {

    @IBOutlet weak var socialWebView: WKWebView!
    var link:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if link.isEmpty {
            
            let image = UIImage(named: "notFound")
            let imageView = UIImageView(image: image!)
            imageView.frame = view.frame
            view.addSubview(imageView)
        }else{
            socialWebView.load(URLRequest(url:URL(string : "https://" + link)!))
            
        }
        
    }
}
