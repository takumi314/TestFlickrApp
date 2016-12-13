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


public protocol URLRequestConvertible {
    /// The URL request.
    var URLRequest: NSMutableURLRequest { get }
}

public protocol EntityType: class { // 識別子を持つ特徴を示すプロトコルです。
    associatedtype IdentityType: Hashable
    var identifier: IdentityType { get }
}

public protocol Parameterizable: class { // パラメータ化できる特徴を示すプロトコルです。
    var parameterize: [String: AnyObject] { get }
}

public protocol RouterType: EntityType, Parameterizable { // ルータで扱える特徴を示すプロトコルです
    associatedtype IdentityType: Hashable, StringInterpolationConvertible
    static var routerName: String { get }
}


// Flickr オブジェクトです。
// ルータと駆動するために必要なプロトコルに準拠しています。
final class Flickr: RouterType {
    
    typealias IdentityType = String
    
    class var routerName: String {
        return "/flickr.photos.search"
    }
    
    let name: String
    let identifier: IdentityType
    
    init(name: String, identifier: String) {
        self.name = name
        self.identifier = identifier
    }
    
    var parameterize: [String: AnyObject] {
        return ["name" : name, "id" : identifier]
    }
}

//// APIリクエストを構成するルータ列挙型です。
//enum CRUDRouter<T: RouterType>: URLRequestConvertible {
//    
//    static var baseURLString: String {
//        return "https://api.flickr.com/services/rest/"
//    }
//    
//    case Create(T)
//    case Read(T.IdentityType)
//    case Update(T)
//    case Destroy(T.IdentityType)
//    
//    var method: Alamofire.Method {
//        switch self {
//        case .Create:
//            return .POST
//        case .Read:
//            return .GET
//        case .Update:
//            return .PUT
//        case .Destroy:
//            return .DELETE
//        }
//    }
//    
//    var path: String {
//        switch self {
//        case .Create:
//            return T.routerName
//        case .Read(let id):
//            return T.routerName + "/\(id)"
//        case .Update(let object):
//            return T.routerName + "/\(object.identifier)"
//        case .Destroy(let id):
//            return T.routerName + "/\(id)"
//        }
//    }
//    
//    // MARK: URLRequestConvertible
//    
//    var URLRequest: NSURLRequest {
//        let URL = NSURL(string: CRUDRouter.baseURLString)!
//        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
//        mutableURLRequest.HTTPMethod = method.rawValue
//        
//        switch self {
//        case .Read(let object):
//                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: object.parameterize).0
//        default:
//                return mutableURLRequest
//        }
//    }
//}
//
//
//let dogCreateRequest = Alamofire.request(CRUDRouter.Create(Dog(name: "pochi", identifier: "d0001")))
//println(dogCreateRequest.debugDescription)


class HTTPNetworking: AnyObject {
    
    internal class func requestAPI() {
        let flickr = FlickrArguments()
        let parameters = organizeWithArguments("flickr.photos.search",
                                               key: "10ba93bbe49a6480d765ce486673954a",
                                               text: "日本",
                                               perPage: "50",
                                               page: "2")
        startGETAccess(flickr.endpoint, parameters: parameters)
    }
    
    internal class func startGETAccess(url: String, parameters: [String: AnyObject]) {
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
    private class func organizeWithArguments(method: String, key: String, text: String, perPage: String, page: String) -> [String: String] {
        let flickr = FlickrArguments()
        let arguments = [flickr.method: method,flickr.apiKey: key, flickr.text: text, flickr.perPage: perPage, flickr.numberOfPage: page]
        return arguments
    }
    
}