//
//  ViewControllerMedia.swift
//  SportsApp
//
//  Created by ola abaza on 4/23/21.
//  Copyright © 2021 Norhan. All rights reserved.
//

import UIKit
import WebKit

class ViewControllerMedia: UIViewController , WKUIDelegate {
    
    @IBOutlet var youtubeWeb: WKWebView!
    var youtubeLink:String = "youtube.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string: "https://\(youtubeLink)")
        
        let myRequest = URLRequest(url: myURL!)
        youtubeWeb.load(myRequest)
        
    }
    
}
