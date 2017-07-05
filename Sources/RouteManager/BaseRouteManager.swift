//
//  BaseRouteManager.swift
//  heartDoctorServer
//
//  Created by 朱佳杰 on 2017/7/4.
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer


open class BaseRouteManager {
    
    public var baseApi: Routes
    var api = Routes() //小的路由
    open static let sharedInstance = BaseRouteManager()
    private init() {
        baseApi = Routes(baseUri: "/baseApi")
    }
    
    public func addURLRoutes(method: HTTPMethod, uri: String, handler: @escaping (HTTPRequest,HTTPResponse) -> () ) {
        api.add(method: method, uri: uri, handler: handler)
        baseApi.add(api)
    }
    
}


