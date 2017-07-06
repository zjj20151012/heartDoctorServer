//
//  UserUploadFileRoute.swift
//  RouteManager
//
//  Created by 朱佳杰 on 2017/7/6.
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

open class UserUploadFileRoute{
    
    public init(method: HTTPMethod, uri: String, handler: @escaping (HTTPRequest, HTTPResponse) -> ()) {
        let baseRouteManager = BaseRouteManager.sharedInstance
        baseRouteManager.addURLRoutes(method: method, uri: uri, handler: handler)
    }
}

