//
//  ParkDetailViewController.swift
//  ParkBook
//
//  Created by April on 2018/4/8.
//  Copyright © 2018年 April. All rights reserved.
//

import UIKit

class ParkDetailViewController: UIViewController {

    var parkInfo: ParkInfoModel?
    var parkOtherPlaces: Array<ParkInfoModel> = []
    
    @IBOutlet weak var parkImage: UIImageView!
    
    @IBOutlet weak var parkName: UILabel!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var openTime: UILabel!
    //@IBOutlet weak var parkIntroduction: UILabel!
    
    @IBOutlet weak var parkIntroduction: UITextView!
    @IBOutlet weak var otherPlaceCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialCollectionView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setInfomation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - setInformation
    
    func setInfomation() {
        guard parkInfo != nil else { return }
        
        if let  imageURLStr = parkInfo?.parkImage {
            let imageURL = URL(string: imageURLStr)
            parkImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "defaultPark"))
        }
        
        parkName.text = parkInfo?.parkName
        placeName.text = parkInfo?.name
        openTime.text = parkInfo?.openTime
        parkIntroduction.text = parkInfo?.parkIntroduction
    }
    
    //MARK: - initail Collection view
    
    func initialCollectionView() {
        otherPlaceCollectionView.dataSource = self
        
        let nib = UINib(nibName: "OtherPlaceCell", bundle: nil)
        otherPlaceCollectionView.register(nib, forCellWithReuseIdentifier: "OtherPlaceCell")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

//MARK: - UICollectionView DataSource

extension ParkDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parkOtherPlaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let otherPlaceInfo: ParkInfoModel = parkOtherPlaces[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherPlaceCell", for: indexPath) as! OtherPlaceCell
        
        if let  imageURLStr = otherPlaceInfo.parkImage {
            let imageURL = URL(string: imageURLStr)
            cell.placeImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "defaultPark"))
        }
        
        cell.placeName.text = otherPlaceInfo.name
        
        return cell
    }
    
    
}
