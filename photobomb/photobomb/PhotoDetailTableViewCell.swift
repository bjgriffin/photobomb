//
//  PhotoDetailTableViewCell.swift
//  photobomb
//
//  Created by BJ Griffin on 7/26/15.
//  Copyright © 2015 mojo. All rights reserved.
//

import UIKit

class PhotoDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var hashtagsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
