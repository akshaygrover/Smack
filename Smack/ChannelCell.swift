//
//  ChannelCell.swift
//  Smack
//
//  Created by akshay Grover on 2017-08-12.
//  Copyright © 2017 akshay Grover. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var channelName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
            
        } else{
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    func configureCell(channel: Channel){
        let title = channel.channelTitle ?? ""
        channelName.text = "#\(title)"
        
        channelName.font = UIFont(name: "AvenirNext-Regular", size: 17)
        
        for id in MessageService.instance.unReadChannels {
            if id == channel.id {
                channelName.font = UIFont(name: "AvenirNext-Bold", size: 22)
                
            }
        }
    }

}
