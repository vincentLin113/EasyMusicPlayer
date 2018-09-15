//
//  SongCell.swift
//  AwesomeMusicPlayer
//
//  Created by Vincent Lin on 2018/9/8.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import Foundation
import UIKit


public class SongCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        imageView.backgroundColor = .blue
        titleLabel.text = "song title"
    }
}


