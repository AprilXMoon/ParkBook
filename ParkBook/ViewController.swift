//
//  ViewController.swift
//  ParkBook
//
//  Created by April on 2018/4/6.
//  Copyright © 2018年 April. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    var dataArray: Array<AnyObject> = []
    var parkDataArray: Array<ParkInfoModel> = []
    var parkHeaderArray: Array<String> = []
    var parkSectionItems: Array<ParkInfoModel> = []
    
    var currentSectionName: String = ""
    
    var activityIndicator: UIActivityIndicatorView?
    
    @IBOutlet weak var parkDataTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "台北市公園景點"
        
        settingTableView()
        downloadDataFromDataTaipei()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - initail
    
    func settingTableView() {
        parkDataTableView.dataSource = self
        parkDataTableView.delegate = self
        
        let nib = UINib(nibName: "ParkListCell", bundle: nil)
        parkDataTableView.register(nib, forCellReuseIdentifier: "ParkListCell")
    }
    
    //MARK: - Load Data
    
    func downloadDataFromDataTaipei() {
        
        addActivityIndicator()
        
        let url = NSURL(string:"http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=bf073841-c734-49bf-a97f-3757a6013812")
        let sessionWithConfigure = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionWithConfigure, delegate: self, delegateQueue: .main)
        
        let dataTask = session.downloadTask(with: url! as URL)
        dataTask.resume()
        
    }
    
    //MARK: - Activity
    
    func addActivityIndicator () {
        activityIndicator = UIActivityIndicatorView(frame: self.view.bounds)
        activityIndicator?.activityIndicatorViewStyle = .whiteLarge
        activityIndicator?.backgroundColor = UIColor(white: 0, alpha: 0.25)
        activityIndicator?.startAnimating()
        
        self.view.addSubview(activityIndicator!)
    }
    
    func stopActivityIndicator () {
        activityIndicator?.removeFromSuperview()
        activityIndicator = nil
    }
}

//MARK: - URLSessionDownloadDelegate

extension ViewController: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        do {
            let parkDataDict = try JSONSerialization.jsonObject(with: NSData(contentsOf: location)! as Data, options: .mutableContainers) as! [String: [String: AnyObject]]
            
            dataArray = parkDataDict["result"]!["results"] as! [AnyObject]
            
            getParkModelArray()
            getParkName()
            
            parkDataTableView.reloadData()
            
            stopActivityIndicator()
            
        } catch {
            print("Error message \(error.localizedDescription)")
        }
    }
    
    private func getParkModelArray() {
        for (_, element) in dataArray.enumerated() {
            let parkInfoModel = ParkInfoModel(parkDict: element as! [String: String])
            parkDataArray.append(parkInfoModel)
        }
        
    }
    
    private func getParkName() {
        
        var parkName = ""
        
        for (_, element) in parkDataArray.enumerated() {
            if parkName != element.parkName! {
                parkHeaderArray.append(element.parkName!)
                parkName = element.parkName!
            }
        }
    }
}

//MARK: - UITableView DataSource

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return parkHeaderArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let parkName = parkHeaderArray[section]
        let parkSectionData = parkDataArray.filter { $0.parkName == parkName }
        
        return parkSectionData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        getCurrentItems(indexPath: indexPath)
        let parkInfo = parkSectionItems[indexPath.item]
        let parkItemTag = parkDataArray.index(of: parkInfo)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParkListCell", for: indexPath) as! ParkListCell
        
        cell.tag = parkItemTag!
        cell.parkName.text = parkInfo.parkName
        cell.name.text = parkInfo.name
        cell.parkIntroduction.text = parkInfo.parkIntroduction
        if let  imageURLStr = parkInfo.parkImage {
            let imageURL = URL(string: imageURLStr)
            cell.parkImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "defaultPark"))
        }
        
        return cell
    }
    
    
    private func getCurrentItems(indexPath: IndexPath) {
        
        let parkName = parkHeaderArray[indexPath.section]
        if parkName != currentSectionName {
            parkSectionItems = parkDataArray.filter{ $0.parkName == parkName }
            currentSectionName = parkName
        }
    }
    
}

//MARK: - UITableView Delegate

extension ViewController: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return parkHeaderArray[section]
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let index = cell?.tag
        
        let parkInfo: ParkInfoModel = parkDataArray[index!]
        let otherPlaces: Array<ParkInfoModel> = parkDataArray.filter {$0.parkName == parkInfo.parkName
            && $0.name != parkInfo.name }
        
        let parkDetailView = ParkDetailViewController()
        parkDetailView.parkInfo = parkInfo
        parkDetailView.parkOtherPlaces = otherPlaces
        
        
        self.navigationController?.pushViewController(parkDetailView, animated: true)
        
    }
}
