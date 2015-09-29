//
//  HeadlineCell.swift
//  StretchMyHeader
//
//  Created by Katherine Peterson on 2015-09-29.
//  Copyright © 2015 KatieExpatriated. All rights reserved.
//

import UIKit

class HeadlineCell: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    
    
    func setCellContents(contents: NewsItem) {
        categoryLabel.text = contents.category
        headlineLabel.text = contents.headline
        
        switch contents.category {
            case "World":
                categoryLabel.textColor = UIColor.init(red: 11.0/255.0, green: 151.0/255.0, blue: 127.0/255.0, alpha: 1.0)
            case "Americas":
                categoryLabel.textColor = UIColor.init(red: 7.0/255.0, green: 157.0/255.0, blue: 178.0/255.0, alpha: 1.0)
            case "Europe":
                categoryLabel.textColor = UIColor.init(red: 192.0/255.0, green: 153.0/255.0, blue: 31.0/255.0, alpha: 1.0)
            case "Middle East":
                categoryLabel.textColor = UIColor.init(red: 158.0/255.0, green: 37.0/255.0, blue: 143.0/255.0, alpha: 1.0)
            case "Africa":
                categoryLabel.textColor = UIColor.redColor()
            default:
                categoryLabel.textColor = UIColor.grayColor()
        }
    }
}