//
//  RoundedBtn.swift
//  Smack
//
//  Created by akshay Grover on 2017-08-11.
//  Copyright © 2017 akshay Grover. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedBtn: UIButton {
    
    @IBInspectable var  cornerRadius: CGFloat = 5.0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        
        self.setupView()
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
        
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }
    

   

}
