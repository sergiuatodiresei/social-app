//
//  MaterialView.swift
//  Social Network
//
//  Created by Sergiu Atodiresei on 01.12.2016.
//  Copyright © 2016 SergiuApps. All rights reserved.
//

import UIKit

class MaterialView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
}
