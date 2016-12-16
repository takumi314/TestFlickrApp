//
//  FlickrAPI.swift
//  TestFlickrApp
//
//  Created by NishiokaKohei on 2016/12/16.
//  Copyright © 2016年 Kohey. All rights reserved.
//

import Foundation
import Alamofire

class Flickr: HTTPNetworking {
    
    // API結果保持用
    var result = [Page]()
    
    func searchFlickrForTerm( input: String) -> Bool {
        
        let dir = FlickrArguments()
        
        Alamofire.request(
            .GET,
            dir.endpoint,
            parameters: [
                            "method": "flickr.photos.search",
                               "key": "10ba93bbe49a6480d765ce486673954a",
                              "text": input,
                           "perpage": "50",
                              "page": "2"
            ]).response { (request, data, response, error) in
                
                if let error = error {
                    print(error)
                    return
                }
                
                if let data = data {
                        self.result = XMLParseManager.parseXML(data)!
                }
                
        }
        return true
    }
    
}
