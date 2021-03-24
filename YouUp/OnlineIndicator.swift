//
//  OnlineIndicator.swift
//  WeSplit
//
//  Created by JJ Stephens on 2/24/21.
//  Copyright © 2021 JJ Stephens. All rights reserved.
//

import Foundation
import UIKit

let offlineColor = UIColor.red
let onlineColor = UIColor.green

class OnlineIndicator: UILabel {
public
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
        StatusChangeToAsleep()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func StatusChangeToUp() {
        self.backgroundColor = onlineColor
        return
    }
    func StatusChangeToAsleep() {
        self.backgroundColor = offlineColor
        return
    }
}
