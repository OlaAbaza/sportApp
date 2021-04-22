//
//  YoutubeViewController.swift
//  SportsApp
//
//  Created by Norhan on 4/22/21.
//  Copyright © 2021 Norhan. All rights reserved.
//

import UIKit
import WebKit

class YoutubeViewController: UIViewController {

   
    @IBOutlet weak var youtubeWebView: WKWebView!
    var youtubeLink:String = ""
       
       override func viewDidLoad() {
           super.viewDidLoad()
           let myURL = URL(string: "https://\(youtubeLink)")
           
           let myRequest = URLRequest(url: myURL!)
           youtubeWebView.load(myRequest)
           
       }
    
}
