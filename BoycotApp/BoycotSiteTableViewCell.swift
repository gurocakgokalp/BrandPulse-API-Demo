//
//  BoycotSiteTableViewCell.swift
//  BoycotApp
//
//  Created by Gökalp Gürocak on 24.10.2025.
//

import UIKit

class BoycotSiteTableViewCell: UITableViewCell {

    @IBOutlet weak var siteLogo: UIImageView!
    @IBOutlet weak var siteUrl: UILabel!
    @IBOutlet weak var siteName: UILabel!
    @IBOutlet weak var stackView1: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        stackView1.isLayoutMarginsRelativeArrangement = true
        stackView1.layoutMargins.bottom = 4
        stackView1.layoutMargins.top = 4
        stackView1.layoutMargins.left = 4
        stackView1.layoutMargins.right = 4
        siteLogo.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
