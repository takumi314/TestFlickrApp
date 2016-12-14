//
//  PhotoViewController.swift
//  TestFlickrApp
//
//  Created by NishiokaKohei on 2016/12/14.
//  Copyright © 2016年 Kohey. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    // MARK: - Properties
    let reuseIdentifier = "FlickrPhotoCell"
    let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    let itemsPerRow: CGFloat = 5
    
    private var searches = [Photo]()
//    private let flickr = Flickr()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


//extension PhotoViewController {
//    
//    func photoForIndexPath(indexPath: IndexPath) -> FlickrPhoto {
//        return searches[(indexPath as NSIndexPath).section].searchResults[(indexPath as NSIndexPath).row]
//    }
//    
//}


// MARK: - UICollectionViewDataSource
extension PhotoViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: cellForItemAtIndexPath) as? FlickrPhotoCell
        cell?.backgroundColor = UIColor.blackColor()
        
        // Configure the cell
        return cell!
    }
    
}


// MARK: - UICollectionViewDelegate
//extension PhotoCollectionViewController: UICollectionViewDelegate {
//    
//}


extension PhotoViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: NSIndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }

}


