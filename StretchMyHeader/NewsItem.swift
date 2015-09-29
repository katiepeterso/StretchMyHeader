//
//  NewsItem.swift
//  StretchMyHeader
//
//  Created by Katherine Peterson on 2015-09-29.
//  Copyright © 2015 KatieExpatriated. All rights reserved.
//

import UIKit

class NewsItem: NSObject {
    let category: String
    let headline: String
    
    init(category: String, headline: String) {
        self.category = category
        self.headline = headline
    }

}
