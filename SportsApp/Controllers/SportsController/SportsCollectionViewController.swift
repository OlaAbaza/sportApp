//
//  SportsCollectionViewController.swift
//  SportsApp
//
//  Created by ola abaza on 4/21/21.
//  Copyright © 2021 Norhan. All rights reserved.
//

import UIKit


private let reuseIdentifier = "SportCell"

class SportsCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    let indicator = Indicator()
    var sports = [Sport]()
    var isOnline :Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.startAnimating(view: self.view)
        self.title = "Sports"
//        self.collectionView!.register(SportsCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        guard NetworkServiceModal.instance.checkInternet() else {
            print("No internet")
            self.showAlert()
            return
        }
        
        NetworkServiceModal.instance.getData(url: URLs.getSportsListURL.rawValue, completion:{(mySports: SportsList?,error) in
                if let myError = error{
                    print(myError)
                }else{
                    guard let sports = mySports else {return}
                    guard let mySport = sports.sports else { return }
                    self.sports = mySport
                    DispatchQueue.main.async {
                        print(self.sports.count)
                        self.collectionView.reloadData()
                        self.indicator.stopAnimating()
                    }
                }
            })
    }
    func showAlert() {
        let alert = UIAlertController(title: "Warning!", message: "Check Your Connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return sports.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)as! SportsCollectionViewCell
        let name = sports[indexPath.row].sportName!
        let image = sports[indexPath.row].sportImg!
        
        cell.setUpSportsCollectionCell(sportName:name, imageName: image)
        
        let layer = CAShapeLayer()
        layer.path  = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.bottomRight, .topLeft , .bottomLeft ,.topRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
        layer.fillColor = UIColor.red.cgColor
        cell.layer.mask = layer
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor(named: "light")?.cgColor
        cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        
//        let rectShape = CAShapeLayer()
//        rectShape.bounds = cell.frame
//        rectShape.position = cell.center
//        rectShape.path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.bottomRight, .topLeft], cornerRadii: CGSize(width: 20, height: 20)).cgPath
//        cell.layer.mask = rectShape
//        cell.layer.borderWidth = 4
//        cell.layer.borderColor = UIColor(named: "light")?.cgColor
//        cell.layer.cornerRadius = cell.frame.width/4
//        cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
    
        return cell
    }
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let leaguesView = storyboard?.instantiateViewController(withIdentifier: "LeaguesViewController") as! ViewController
        //leaguesView.sportName = sports[indexPath.row].strSport!
        
//        self.navigationController?.pushViewController(leaguesView, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width * 0.47, height: collectionView.frame.size.width * 0.34)
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8)
    }
  
 


}
    

