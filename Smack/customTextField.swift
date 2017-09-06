//
//  customTextField.swift
//  Smack
//
//  Created by akshay Grover on 2017-08-14.
//  Copyright © 2017 akshay Grover. All rights reserved.
//

import UIKit

class customTextField: UITextField {
    
   

    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 25);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }

}
