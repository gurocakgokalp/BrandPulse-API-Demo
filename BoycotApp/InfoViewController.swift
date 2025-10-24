//
//  InfoViewController.swift
//  BoycotApp
//
//  Created by Gökalp Gürocak on 24.10.2025.
//

import UIKit
import SDWebImage

class InfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var titleBrand: String?
    var boycottingWebsitesURL: [URL]?
    var boycottingWebsitesName: [String]?
    var favicons: [String]?
    var descBrand: String?
    @IBOutlet weak var descBrandLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelDeneme: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelDeneme.text = titleBrand
        descBrandLabel.text = descBrand
        tableView.delegate = self
        tableView.layer.cornerRadius = 8
        
        tableView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .close)
        print(boycottingWebsitesName)
        print(boycottingWebsitesURL?.count)
        
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BoycotSiteTableViewCell
        
        let faviconUrl = URL(string: "https://isboykot.com\(favicons![indexPath.row])")
        if boycottingWebsitesName!.count > 0 {
            cell.siteName.text = boycottingWebsitesName![indexPath.row]
        }
        
        
        if boycottingWebsitesURL!.count > 0 {
            cell.siteUrl.text = boycottingWebsitesURL![indexPath.row].absoluteString
            cell.siteLogo.sd_setImage(with: faviconUrl, placeholderImage: UIImage(named: "placeholder"))
            
        }
        
        /*
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = boycottingWebsitesName?[indexPath.row]
        content.secondaryText = boycottingWebsitesURL![indexPath.row].absoluteString
        content.textProperties.font = .boldSystemFont(ofSize: 17)
        content.secondaryTextProperties.color = .secondaryLabel
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        content.image
        content.imageProperties.cornerRadius = 4
        cell.contentConfiguration = content
         
         */

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boycottingWebsitesURL?.count ?? 0
    }
    
    
    /*
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
     }
    */

}
