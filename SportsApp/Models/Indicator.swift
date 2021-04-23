//
//  Indicator.swift
//  SportsApp
//
//  Created by ola abaza on 4/21/21.
//  Copyright © 2021 Norhan. All rights reserved.
//

import Foundation
import UIKit

class Indicator{
    var activityIndicator: UIActivityIndicatorView!
    func startAnimating(view: UIView){
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
    }
    func stopAnimating(){
        activityIndicator.stopAnimating()
    }
}
