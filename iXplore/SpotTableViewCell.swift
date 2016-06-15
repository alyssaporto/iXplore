//
//  SpotTableViewCell.swift
//  iXplore
//
//  Created by Alyssa Porto on 6/13/16.
//  Copyright © 2016 Alyssa Porto. All rights reserved.
//

import UIKit

class SpotTableViewCell: UITableViewCell {
    
    var logoImage = UIImageView()
    var cellLabel = UILabel()
    var dateLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let logoImageFrame = CGRectMake(0, 0, self.frame.height, self.frame.height)
        logoImage = UIImageView(frame: logoImageFrame)
        self.addSubview(logoImage)
        
        let cellLabelFrame = CGRectMake(125, 10, self.frame.width - self.frame.height - 100, self.frame.height/2)
        cellLabel = UILabel(frame: cellLabelFrame)
        self.addSubview(cellLabel)
        
        let dateLabelFrame = CGRectMake(125, 30, 200, self.frame.height/2)
        dateLabel = UILabel(frame: dateLabelFrame)
        self.addSubview(dateLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
