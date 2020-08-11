//
//  DetailTableViewCell.swift
//  HclAssignment
//
//  Created by admin on 10/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let profileImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false 
        img.layer.cornerRadius = 25
        img.clipsToBounds = true
        return img
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.textColor = .black
        //label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let jobTitleDetailedLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.lineBreakMode = .byWordWrapping
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let marginGuide = contentView.layoutMarginsGuide
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(jobTitleDetailedLabel)
        self.contentView.addSubview(profileImageView)
        
        profileImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant:50).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor,constant:28).isActive = true
        nameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        nameLabel.numberOfLines = 0
        
        jobTitleDetailedLabel.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant:30).isActive = true
        jobTitleDetailedLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        jobTitleDetailedLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        jobTitleDetailedLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        jobTitleDetailedLabel.numberOfLines = 0
        jobTitleDetailedLabel.font = UIFont(name: "FontAwesome", size: 12)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
}
