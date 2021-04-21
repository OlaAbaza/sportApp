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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.startAnimating(view: self.view)
        self.title = "Sports"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
    
//        self.collectionView!.register(SportsCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.global(qos: .background).async {
            NetworkServiceModal.instance.getData(url: URLs.getSportsListURL, completion:{(mySports: SportsList?,error) in
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
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = cell.frame
        rectShape.position = cell.center
        rectShape.path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.bottomRight, .topLeft], cornerRadii: CGSize(width: 20, height: 20)).cgPath
        cell.layer.mask = rectShape
        cell.layer.borderWidth = 4
        cell.layer.borderColor = UIColor(named: "light")?.cgColor
        cell.layer.cornerRadius = cell.frame.width/4
        cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
    
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width * 0.47, height: collectionView.frame.size.width * 0.34)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leaguesView = storyboard?.instantiateViewController(withIdentifier: "LeaguesViewController") as! ViewController
        //leaguesView.sportName = sports[indexPath.row].strSport!
        
        self.navigationController?.pushViewController(leaguesView, animated: true)
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
  
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
    

