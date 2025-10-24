//
//  ViewController.swift
//  BoycotApp
//
//  Created by Gökalp Gürocak on 23.10.2025.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    var ViewModel: tableViewBoycottViewModel?
    var currentSheetVController: InfoViewController?
    var isSheetOn: Bool = false
    var searching: Bool = false
    var searchingBrand = String()
    //filter

    let enumType: [boycotStatusColor] = [.boycott, .boycott, .notBoycott]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Boykot mu Değil mi?"
        navigationItem.subtitle = "Markaların boykot durumunu öğrenin."
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Bir marka arayın."
        navigationItem.searchController = searchController
        //uISearchBar.searchBarStyle
        //let accessory = UITabAccessory(contentView: uISearchBar)
        //tabBarController?.bottomAccessory = accessory
        tabBarController?.tabBarMinimizeBehavior = .onScrollDown
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let gestureRecognzier = UITapGestureRecognizer(target: self, action: #selector(closeSheet))
        //view.addGestureRecognizer(gestureRecognzier)
        
        setupRefreshControl()

        //navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .search)
        
        Task {
            await fetchRequest()
        }
        
    }
    @objc func closeSheet(){
        if isSheetOn {
            currentSheetVController?.dismiss(animated: true)
            isSheetOn = false
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        if text != "" {
            print("Text: \(text)")
            searching = true
            searchingBrand = text
        } else {
            // text boş.
            searching = false
        }
        
        Task {
            await fetchRequest()
        }
    }
    
    
    func fetchRequest() async {
        if !searching {
            let defaultUrl = "https://isboykot.com/api/brands/random?skip=5"
            
            do {
                print("loading default")
                navigationItem.subtitle = "Loading..."
                let fetchingDatas = try await Webservice().fetchDatas(url: defaultUrl)
                
                self.ViewModel = tableViewBoycottViewModel(brandArray: fetchingDatas.data)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    if defaultUrl == "https://isboykot.com/api/brands/random?skip=5" {
                        self.navigationItem.subtitle = "Öne Çıkan Markalar"
                    } else {
                        self.navigationItem.subtitle = "Markaların boykot durumunu öğrenin."
                    }
                    print("loaded! HHHEY")
                }
            } catch {
                print(error.localizedDescription)
            }
        } else {
            if self.searchingBrand != "" {
                let defaultUrl = "https://isboykot.com/api/brands?name=\(self.searchingBrand)&count=7"
                
                do {
                    print("loading")
                    navigationItem.subtitle = "Loading..."
                    let fetchingDatas = try await Webservice().fetchDatas(url: defaultUrl)
                    
                    self.ViewModel = tableViewBoycottViewModel(brandArray: fetchingDatas.data)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        if defaultUrl == "https://isboykot.com/api/brands/random?skip=5" {
                            self.navigationItem.subtitle = "Öne Çıkan Markalar"
                        } else {
                            self.navigationItem.subtitle = "Markaların boykot durumunu öğrenin."
                        }
                        print("loaded! HHHEY")
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            
        }
        
    }
    
    func showSheet(){
        
    }

    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc private func handleRefresh() {
        Task {
            await fetchRequest()
            tableView.refreshControl?.endRefreshing()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController else {
            return
        }

        vc.titleBrand = ViewModel?.indexPathCek(indexPath.row).brand.name
        vc.descBrand = ViewModel?.indexPathCek(indexPath.row).boycottingInfo
        vc.boycottingWebsitesName = ViewModel?.indexPathCek(indexPath.row).boycottingSiteNames
        vc.boycottingWebsitesURL = ViewModel?.indexPathCek(indexPath.row).boycottingSiteURLs
        vc.favicons = ViewModel?.indexPathCek(indexPath.row).favicon
        

        print("Boykot edenler: \(ViewModel?.indexPathCek(indexPath.row).boycottingSiteNames)")
        
        vc.modalPresentationStyle = .pageSheet
        currentSheetVController = vc
        //isSheetOn = true

        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }

        present(vc, animated: true, completion: nil)
        
        
        //showMyViewControllerInACustomizedSheet()
    }

    /*
    func showMyViewControllerInACustomizedSheet() {
        let viewControllerToPresent = DenemeViewController()
        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BrandTableViewCell
        /*
        if enumType.count > 0 {
            switch enumType[indexPath.row] {
            case .boycott:
                //cell.bgStaack.backgroundColor = .systemRed
                cell.boycottLabel.textColor = .systemRed
                cell.boycottLabel.text = "Boycott"
            case .none:
                //cell.bgStaack.backgroundColor = .clear
                cell.boycottLabel.textColor = .secondaryLabel
                cell.boycottLabel.text = "Unknown"
            case .notBoycott:
                //cell.bgStaack.backgroundColor = .systemGreen
                cell.boycottLabel.textColor = .systemGreen
                cell.boycottLabel.text = "Clear"
            }
        } else {
            cell.bgStaack.backgroundColor = .clear
        }
         */
        
        if ViewModel?.indexPathCek(indexPath.row).boycottingCount ?? 0 > 0 {
            cell.boycottLabel.textColor = .systemRed
            cell.boycottLabel.text = "Boykot"
        } else {
            cell.boycottLabel.textColor = .systemGreen
            cell.boycottLabel.text = "Temiz"
        }
        
        
        cell.brandLabel.text = ViewModel?.indexPathCek(indexPath.row).brand.name
        cell.detailsBrandLabel.text = ViewModel?.indexPathCek(indexPath.row).boycottingInfo
        
        let urlSonu = ViewModel?.indexPathCek(indexPath.row).brand.image
        
        let imageUrl = URL(string: "https://isboykot.com\(urlSonu!)")
        
        cell.logoImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(systemName: "image"))
        print(imageUrl!)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewModel?.numberOfRowsInSection() ?? 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
            print("hey")
        }
    }
}

