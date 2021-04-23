//
//  YoutubeViewController.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/27/21.
//

import UIKit
import WebKit

class YoutubeViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet var youtubeWeb: WKWebView!
   // var youtubeLink:String = "www.youtube.com\/user\/officialburnleyfc"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string: "https://\(youtubeLink)")
        
        let myRequest = URLRequest(url: myURL!)
        youtubeWebView.load(myRequest)
        
    }
    
}
