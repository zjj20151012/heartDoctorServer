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
import RouteManager
import DataBaseManager

//访问权限 open > public > interal > fileprivate > private

open class UserRegistServerManager:BaseServerManager {
    public override init(){
        super.init()
        let _ = UserRegistRoute.init(method: .post, uri: "/regist") { (request, response) in
            var jsonString = ""
            let DBManager = UserRegistDBManager()
            //      let params: Array = request.queryParams  //get请求方式
            let params: Array = request.params() //post请求方式获取所有参数
            var realParam: [(String,String)] = []
            var dataParam: [[String:String]] = []
            for (index,(var key,var value)) in params.enumerated() {
                
                print("\(index)" + "->" + "\(params.endIndex)")
                dataParam.append([key:value])
                if (index == params.endIndex - 1){
                    value = "'" + value + "'"
                }else{
                    key += ","
                    value = "'" + value + "'" + ","
                }
                realParam.append((key,value))
             }
            print(params)
            let result = DBManager.insertDatabaseSQL(tableName: "user_regist", columnAndValue: realParam)
            if (result.success){
                jsonString = self.baseResponseBodyJSONData(status: 200, message: "成功", data: dataParam)
            }else {
                jsonString = self.baseResponseBodyJSONData(status: 100, message: result.errorMsg, data: ["无数据"])
            }
            response.setBody(string: jsonString)
            response.completed()
        }
    }
}

