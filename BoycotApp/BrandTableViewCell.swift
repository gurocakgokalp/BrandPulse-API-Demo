//
//  BrandTableViewCell.swift
//  BoycotApp
//
//  Created by Gökalp Gürocak on 23.10.2025.
//

import UIKit

class BrandTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var detailsBrandLabel: UILabel!
    @IBOutlet weak var boycottLabel: UILabel!
    @IBOutlet weak var bgMainStack: UIStackView!
    @IBOutlet weak var bgStaack: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bgMainStack.isLayoutMarginsRelativeArrangement = true
        bgStaack.isLayoutMarginsRelativeArrangement = true
        bgStaack.layoutMargins.bottom = 1
        bgStaack.layoutMargins.top = 1
        bgStaack.layoutMargins.left = 1
        bgStaack.layoutMargins.right = 1
        
        bgMainStack.layoutMargins.bottom = 8
        bgMainStack.layoutMargins.top = 8
        bgMainStack.layoutMargins.left = 8
        bgMainStack.layoutMargins.right = 8
        
        logoImageView.layer.cornerRadius = 12
        
        bgMainStack.layer.cornerRadius = 16
        bgStaack.layer.cornerRadius = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
