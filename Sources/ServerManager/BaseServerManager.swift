//
//  BaseServerManager.swift
//  ServerManager
//
//  Created by 朱佳杰 on 2017/7/4.
//


//
//  NetworkServerManager.swift
//  heartDoctorServer
//
//  Created by 朱佳杰 on 2017/6/29.
//

import Foundation
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import DataBaseManager
import RouteManager

//访问权限 open > public > interal > fileprivate > private

open class BaseServerManager {
    
    var server: HTTPServer = HTTPServer.init()
    public init() {
        server.serverPort = 8081                        //端口
        let baseRouteManage = BaseRouteManager.sharedInstance
        let mainRoute = baseRouteManage.baseApi
        server.addRoutes(mainRoute)
        server.documentRoot = "webroot"                 //根目录
        server.setResponseFilters([(Filter404(),.high)])//404过滤
        
        print(mainRoute)
    }
        
    //MARK: 开启服务
    open func startServer() {
        
        do {
            print("启动HTTP服务器")
            try server.start()
        } catch PerfectError.networkError(let err, let msg){
            print("启动失败：code:\(err) msg:\(msg)")
        } catch {
            print("启动失败：未知错误")
        }
        
    }
    
    //MARK: 通用响应格式
    public func baseResponseBodyJSONData(status: Int, message: String, data: Any!) -> String {
        
        var result = Dictionary<String, Any>() //创建一个字典
        result.updateValue(status, forKey: "status")
        result.updateValue(message, forKey: "message")
        if (data != nil) {
            result.updateValue(data, forKey: "data")
        }else {
            result.updateValue("", forKey: "data")
        }
        //当条件不满足时执行
        guard let jsonString = try? result.jsonEncodedString() else {
            return ""
        }
        return jsonString
    }
    
    //MARK: 404过滤
    struct Filter404: HTTPResponseFilter {
        
        func filterBody(response: HTTPResponse, callback: (HTTPResponseFilterResult) -> ()) {
            callback(.continue)
        }
        
        func filterHeaders(response: HTTPResponse, callback: (HTTPResponseFilterResult) -> ()) {
            if case .notFound = response.status {
                response.setBody(string: "404 文件\(response.request.path)不存在。")
                response.setHeader(.contentLength, value: "\(response.bodyBytes.count)")
                callback(.done)
            }else {
                callback(.continue)
            }
        }
        
    }
}

