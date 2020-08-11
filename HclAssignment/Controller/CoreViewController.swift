//
//  CoreViewController.swift
//  HclAssignment
//
//  Created by admin on 10/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import CoreData

class CoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let imageTableView = UITableView() // view
    
    var refresher:UIRefreshControl!
    var dataSourceArray = [ImageModal]() // model

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Checking Internet Connection To Show data and Images in offline
        
        let isInternetAvailable = Reachability().isConnectedToNetwork()
               if isInternetAvailable {
                   dataSourceArray.removeAll()
                   loadDataFromServer()
               } else {
                   dataSourceArray.removeAll()
                   getImageData()
               }
        initialSetup()
        tableviewContriants()
   }
    
    func tableviewContriants(){
        view.backgroundColor = .white
        view.addSubview(imageTableView)
        self.imageTableView.backgroundColor = UIColor.clear
        self.imageTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        imageTableView.translatesAutoresizingMaskIntoConstraints = false
        
        imageTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        imageTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        imageTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        imageTableView.dataSource = self
        imageTableView.delegate = self
        imageTableView.register(DetailTableViewCell.self, forCellReuseIdentifier: "contactCell")
}

    
    //MARK: Private functions
    private func initialSetup() {
        // setup refresh control to refresh images and data
        self.refresher = UIRefreshControl()
        self.imageTableView.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.red
        self.refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.imageTableView.addSubview(refresher)
    }
    
    @objc private func refreshData() {
        stopRefresher()
    }
    
    private func stopRefresher() {
        self.refresher.endRefreshing()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! DetailTableViewCell
        
        let modal = self.dataSourceArray[indexPath.row]
        cell.jobTitleDetailedLabel.text = modal.imageDescription
        cell.jobTitleDetailedLabel.numberOfLines=0
        cell.nameLabel.text = modal.title
        
        DispatchQueue.main.async(execute: {
            cell.profileImageView.image = UIImage(named: "noresponse")
        })
        
        if let url = URL(string: modal.imageHref) {
            if let imageD = modal.image {
                cell.profileImageView.image = imageD
                DispatchQueue.main.async(execute: {
                    cell.profileImageView.image = imageD
                })
            } else {
                
                cell.profileImageView.sd_setImage(with: url) { (image, error, cacheType, url) in
                    if let image = image {
                        self.dataSourceArray[indexPath.row].image = image
                        cell.profileImageView.image = image
                        // updated in main thread
                        DispatchQueue.main.async(execute: {
                            cell.profileImageView.image = image
                        })
                    } else {
                        
                    }
                }
            }
        }
        
        return cell
    }
    
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
  //MARK:- Web api section
    
    private func loadDataFromServer() {
        
        ServiceHelper.request(params: [:], method: .get, apiName: "facts.json") { (response, error, httpCode) in
            self.stopRefresher()
            if let error = error {
                // Alert should be shown
            } else {
                
                if let infoDictionary = response as? Dictionary<String, AnyObject> {
                    let collectionModal = CollectionModal(object: infoDictionary)
                    self.title = collectionModal.title
                    self.dataSourceArray = collectionModal.rows
                    self.storeImageInLocal(imageModelData: collectionModal)
                    self.imageTableView.reloadData()
                }
            }
        }
    }
    
    // Storing Images and data in local
    func storeImageInLocal(imageModelData: CollectionModal) {
        
        let imageFields = ImageRowsDTO()
        let imageDetailData = dataSourceArray
        for country in imageDetailData {
            let predicateTitle = NSPredicate(format: "name = %@", country.title)
            let managedobject = CoreDataHandler().fetchEntityDetailsWithRequestPredicate(entityName: "CoreImage", predicate: predicateTitle) as! [CoreImage]
            if managedobject.count == 0 {
            imageFields.description = country.imageDescription
            imageFields.title = country.title
            imageFields.image = country.imageHref
            CoreImage.saveImageDetails(countryInfo: imageFields, title: imageModelData.title)
            }
        }
        getImageData()
    }
    
    // fetch images and data 
    
    func getImageData() {
        let fetch = CoreDataHandler().fetchEntityDetails(entityName: "CoreImage")
        
        dataSourceArray.removeAll()
        
        for data in fetch {
            let imageModelData = ImageModal()
            imageModelData.imageDescription = data.value(forKey: "desc") as! String
            
            imageModelData.imageHref = data.value(forKey: "imageURL") as! String
            imageModelData.title = data.value(forKey: "name") as! String
            print("Title: \(imageModelData.title), Image: \(imageModelData.imageHref), Description: \(imageModelData.imageDescription)")
            dataSourceArray.append(imageModelData)
        }
        print("Datas : \(dataSourceArray.count)")
    }
    
}
