//
//  ActivityIndicatorView.swift
//  TestFlickrApp
//
//  Created by NishiokaKohei on 2016/12/16.
//  Copyright © 2016年 Kohey. All rights reserved.
//

import UIKit

protocol ActivityIndicatorViewDelegate {
    func start()
}

class ActivityIndicatorView: UIActivityIndicatorView {
    
    var delegate: ActivityIndicatorViewDelegate?
    
    var style: UIActivityIndicatorViewStyle?

}
