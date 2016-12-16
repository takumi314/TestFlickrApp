//
//  PhotoCollectionView.swift
//  TestFlickrApp
//
//  Created by NishiokaKohei on 2016/12/15.
//  Copyright © 2016年 Kohey. All rights reserved.
//

import UIKit

protocol PhotosViewDelegate: UISearchBarDelegate {
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
}


class PhotosView: UIView {

    @IBOutlet weak var flickrSearchBar: UISearchBar?
    
    let seaechIcon: UISearchBarIcon = .Clear
    let keyword: String = "キーワード検索"
    static let input: String = ""
    
    var delegate: PhotosViewDelegate?
    
}




extension PhotosView: UISearchBarDelegate {

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    }

}