//
//  PhotoViewController.swift
//  TestFlickrApp
//
//  Created by NishiokaKohei on 2016/12/14.
//  Copyright © 2016年 Kohey. All rights reserved.
//

import UIKit

protocol PhotoViewControllerDelegate {
    
    func searchingForText(text: String)    //
    
}


class PhotoViewController: UIViewController {
    
    // MARK: - Properties
    let reuseIdentifier = "FlickrPhotoCell"
    let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    let itemsPerRow: CGFloat = 5
    let flickr = Flickr()
    
    @IBOutlet weak var photosView: PhotosView?

    
    var delegate: PhotoViewControllerDelegate?
    var dataSource: UICollectionViewDataSource?
    var searches = [Photo]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photosView?.delegate = self
        self.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


// MARK: - UICollectionViewDataSource

extension PhotoViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return searches.count
    }
    
    func collectionView(collectionView: UICollectionView,
                        cellForItemAtIndexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier,
                                                                         forIndexPath: cellForItemAtIndexPath) as? FlickrPhotoCell
        cell?.backgroundColor = UIColor.blackColor()
        
        let urlString = HTTPNetworking.photoSource(searches[cellForItemAtIndexPath.row])
        let photoURL = NSURL(string: urlString)
        let reqest = NSURLRequest(URL:photoURL!)

        NSURLConnection
            .sendAsynchronousRequest(reqest,
                                     queue:NSOperationQueue
                                            .mainQueue()) { (res, data, err) in
                                                if let image = UIImage(data:data!) {
                                                    print(image)
                                                    cell?.photoImage?.image = image
                                                } else if let error = err {
                                                    print(error)
                                                }
            
                                            }
        
        /**
            let mainQueue = dispatch_get_main_queue()
            let grobalQueue = dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)
            dispatch_sync(mainQueue, {
                print("同期") // 画像取得
                            dispatch_async(grobalQueue, {
                    print("非同期")   // 画像表示
                })
            })
        */
 
        return cell!
    }
    
}

extension PhotoViewController: UICollectionViewDelegate {

}

extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    
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


extension PhotoViewController: PhotosViewDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
            
        // 検索ボタン クリック後の処理
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        photosView!.photoCollectionView!.addSubview(activityIndicator)
        activityIndicator.frame = photosView!.bounds
        activityIndicator.startAnimating()

        
        if flickr.searchFlickrForTerm(searchBar.text!) {
            
            // インジケータ停止
            activityIndicator.removeFromSuperview()
            
            guard let pages = flickr.result as [Page]? else {
                return
            }
            
            for page in pages {
                print(" page : \(page)")
            }
        
            // レロード処理
            photosView!.photoCollectionView?.reloadData()

            
        } else {
            print("Fail to download")
        }
        
    }
    
}


