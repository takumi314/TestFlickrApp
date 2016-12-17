//
//  FlickrAPI.swift
//  TestFlickrApp
//
//  Created by NishiokaKohei on 2016/12/16.
//  Copyright © 2016年 Kohey. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Flickr: HTTPNetworking {
    
    let dir = FlickrArguments()
    // API結果保持用
    var result = [Page]()
    
    // APIリクエスト
    func searchFlickrForTerm(input: String) -> Bool {
        
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
                
                if let response = response {
                        self.result = XMLParseManager.parseXML(response)!
                }
                
        }
        return true
    }
    
    func searchFlickrWithJSON(input: String) {
        Alamofire.request(.GET,
                          dir.endpoint,
                          parameters: [
                                        "method": "flickr.photos.search",
                                        "key": "10ba93bbe49a6480d765ce486673954a",
                                        "text": input,
                                        "perpage": "50",
                                        "page": "2"
            ]).responseJSON { responseData in
                
                guard let data = responseData.result.value else {
                    return
                }
        
                let jasonDATA = JSON(data)
                self.getData(jasonDATA)
        
        }
    }

    private func getData(swifyJSON: JSON) {
        guard let object = swifyJSON.array else {
            return
        }
        
        print(object)
        
    }
    
    
    
}
