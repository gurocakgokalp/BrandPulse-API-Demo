//
//  BoycottViewModel.swift
//  BoycotApp
//
//  Created by Gökalp Gürocak on 23.10.2025.
//

import Foundation

struct tableViewBoycottViewModel {
    let brandArray: [Brand]
    
    func numberOfRowsInSection() -> Int {
        return self.brandArray.count
    }
    
    func indexPathCek(_ index: Int) -> BrandViewModel {
        let brand = self.brandArray[index]
        return BrandViewModel(brand: brand)
    }
}

struct BrandViewModel {
    let brand: Brand
    
    var name: String {
        return self.brand.name
    }
    
    var image: String {
        return self.brand.image
    }
    
    var boycottingCount: Int {
        return self.brand.websites.count
    }
    
    var boycottingSiteNames: [String] {
        return self.brand.websites.filter {$0.isBoycotting}.map {$0.website.name}
    }
    
    var boycottingSiteURLs: [URL] {
        return self.brand.websites.filter {$0.isBoycotting}.map {$0.website.url}
    }
    
    var boycottingInfo: String {
        return "\(String(boycottingCount)) site boykot ediyor."
    }
    
    var favicon: [String] {
        return self.brand.websites.filter {$0.isBoycotting}.map {$0.website.favicon}
    }
}
