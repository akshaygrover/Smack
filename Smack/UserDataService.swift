//
//  UserDataService.swift
//  Smack
//
//  Created by akshay Grover on 2017-08-11.
//  Copyright © 2017 akshay Grover. All rights reserved.
//

import Foundation

class UserDataService {
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String) {
        
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
        
    }
    
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName 
    }
    func returnUIColor(components: String) -> UIColor {
        
        let scanner = Scanner(string: components)
        
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r,g,b,a : NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        
        guard let rUnwraped = r else { return defaultColor }
        guard let gUnwraped = g else { return defaultColor }
        guard let bUnwraped = b else { return defaultColor }
        guard let aUnwraped = a else { return defaultColor }
        
         let rFloat = CGFloat(rUnwraped.doubleValue)
         let gFloat = CGFloat(gUnwraped.doubleValue)
         let bFloat = CGFloat(bUnwraped.doubleValue)
         let aFloat = CGFloat(aUnwraped.doubleValue)
        
        let newColor = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
        
        return newColor
   
    }
    func logout() {
        id = ""
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
        MessageService.instance.clearChannels()
        MessageService.instance.clearMessages()
        
    }
    
}
