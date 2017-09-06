//
//  AddChannelVC.swift
//  Smack
//
//  Created by akshay Grover on 2017-08-12.
//  Copyright © 2017 akshay Grover. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    @IBOutlet weak var channelNameField: UITextField!
    
    @IBOutlet weak var channelDescField: UITextField!
    
    @IBOutlet weak var bgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    @IBAction func closeModelTapped(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func createChannelTapped(_ sender: RoundedBtn) {
        guard let channelname = channelNameField.text, channelNameField.text != "" else { return }
        guard let channelDesc = channelDescField.text else { return }
        
        SocketService.instance.addChannel(channelName: channelname, channelDesc: channelDesc) { (sucess) in
            if sucess {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func setupView(){
        let closeTap = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeGesture(_:)))
        bgView.addGestureRecognizer(closeTap)
        
        channelNameField.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSForegroundColorAttributeName: smackPurplePlaceholder])
        channelDescField.attributedPlaceholder = NSAttributedString(string: "descrription", attributes: [NSForegroundColorAttributeName: smackPurplePlaceholder])
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        visualEffectView.frame = bgView.bounds
        bgView.addSubview(visualEffectView)
    }
    
    func closeGesture(_ gesture: UITapGestureRecognizer){
        
        dismiss(animated: true, completion: nil)
        
    }
}
