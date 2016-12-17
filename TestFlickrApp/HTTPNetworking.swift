//
//  HTTPNetworking.swift
//  TestFlickrApp
//
//  Created by NishiokaKohei on 2016/12/10.
//  Copyright © 2016年 Kohey. All rights reserved.
//

import Alamofire

struct FlickrArguments {
    let endpoint = "https://api.flickr.com/services/rest/"
    let method = "method"
    let apiKey = "api_key"
    let text = "text"
    let perPage = "per_page"
    let numberOfPage = "page"
}


class HTTPNetworking: AnyObject {

    class func startGETAccess(url: String, parameters: [String: AnyObject]) {
        let flickr = FlickrArguments()
        Alamofire.request(.GET, flickr.endpoint, parameters: parameters)
            .response { (request, response, data, error) in
                print(request)
                print(response)
                print(data) // if you want to check XML data in debug window.
                print(error)
        }
    }
    
    // flickr用のパラメーターを生成する
    func organizeWithArguments(method: String, key: String, text: String, perPage: String, page: String) -> [String: String] {
        let flickr = FlickrArguments()
        let arguments = [flickr.method: method,flickr.apiKey: key, flickr.text: text, flickr.perPage: perPage, flickr.numberOfPage: page]
        return arguments
    }
    
}

extension HTTPNetworking {
    
    // APIデータをPhotoで渡すとURLが返す
    class func photoSource(photo: Photo) -> String {
        return photoSourceURL(photo.farm, id: photo.id, server: photo.server, secret: photo.secret)
    }
    
    // (例) https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_[mstzb].jpg
    private class func photoSourceURL( farm: Int, id: Int, server: Int, secret: String) -> String {
        let url = "https://farm\(String(farm))"
                    + ".staticflickr.com/\(String(server))"
                    + "/\(String(id))"
                    + "_\(String(secret))_s.jpg"
        return url
    }
    
}











