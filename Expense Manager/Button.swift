//
//  Button.swift
//  Assignment_4
//
//  Created by JD on 2022-12-05.
//

import UIKit

@IBDesignable
final class btn: UIButton {
    
    override init(frame: CGRect){
            super.init(frame: CGRect(x: 0, y: 0, width: 60 , height:60))
        }
    
    required init?(aDecoder: NSCoder) {
             super.init(aDecoder: aDecoder)
         }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            setup()
        }
    
    func setup() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 30
        self.backgroundColor = .systemBlue
        
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        self.setImage(image, for: .normal)
        self.tintColor = .white
        self.setTitleColor(.white, for: .normal)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.3
        }
    
}
