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

//访问权限 open > public > interal > fileprivate > private

open class UserRegistServerManager {
    //fileprivate声明在此文件中私有
    fileprivate var server: HTTPServer
    public init() {
        
        server = HTTPServer.init()                      //初始化HTTPserver服务器
        var routes = Routes.init(baseUri: "/baseApi")   //创建路由
        configure(routes: &routes)                      //注册路由
        server.addRoutes(routes)                        //添加路由至服务
        server.serverPort = 8081                        //端口
        server.documentRoot = "webroot"                 //根目录
        server.setResponseFilters([(Filter404(),.high)])//404过滤
        
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
    
    //MARK: 注册路由
    fileprivate func configure(routes: inout Routes) {
        
        routes.add(method: .get, uri: "/name") { (request, response) in
            var jsonString = ""
            let DBManager = DatabaseManager()
            if let result = DBManager.mysqlGetHomeDataResult() {
                jsonString = self.baseResponseBodyJSONData(status: 200, message: "成功", data: result)
            }else {
                jsonString = self.baseResponseBodyJSONData(status: 100, message: "失败", data: ["无数据"])
            }
            response.setBody(string: jsonString)
            response.completed()
            
        }
        
    }
//    inout 修饰的参数当其值在函数中被改变的时候原来的值也会被改变
//    fileprivate func configure(routes: inout Routes) {
//
//        //添加接口、请求方式、路径
//        routes.add(method: .get, uri: "/") { (request,response) in
//            response.setHeader(.contentType, value: "text/html") //响应头
//            let jsonDict = ["key":"value"]
//            let jsonString = self.baseResponseBodyJSONData(status: 200, message: "成功", data: jsonDict)
//            response.setBody(string: jsonString) //响应体
//            response.completed()                 //完成响应
//        }
//
//    }
    
    //MARK: 通用响应格式
    func baseResponseBodyJSONData(status: Int, message: String, data: Any!) -> String {
        
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

