//
//  PhotoView.swift
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
    weak var photoCollectionView: PhotoCollectionView?
    
    let seaechIcon: UISearchBarIcon = .Clear
    let keyword: String = "キーワード検索"
    let input: String = ""
    
    var delegate: PhotosViewDelegate?
    
}




extension PhotosView: UISearchBarDelegate {

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        HTTPNetworking.requestAPI((flickrSearchBar!.text)!)
    }

}


extension PhotosView: ActivityIndicatorViewDelegate {
    
    func start() {
        let activityIndicator = ActivityIndicatorView(activityIndicatorStyle: .Gray)
        photoCollectionView!.addSubview(activityIndicator)
        activityIndicator.frame = photoCollectionView!.bounds
        activityIndicator.startAnimating()
        
        activityIndicator.removeFromSuperview()
            
        photoCollectionView?.reloadData()
        
    }
    
}
