//
//  CircleView.swift
//  devslopes-social
//
//  Created by Benjamin Neal on 1/10/17.
//  Copyright © 2017 Benjamin Neal. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }

}
