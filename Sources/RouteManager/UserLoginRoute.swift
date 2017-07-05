//
//  UserLoginRoute.swift
//  RouteManager
//
//  Created by 朱佳杰 on 2017/7/4.
//

//
//  UserRegistRoute.swift
//  heartDoctorServer
//
//  Created by 朱佳杰 on 2017/7/4.
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

open class UserLoginRoute{
    
    public init(method: HTTPMethod, uri: String, handler: @escaping (HTTPRequest, HTTPResponse) -> ()) {
        let baseRouteManager = BaseRouteManager.sharedInstance
        baseRouteManager.addURLRoutes(method: method, uri: uri, handler: handler)
    }
}

