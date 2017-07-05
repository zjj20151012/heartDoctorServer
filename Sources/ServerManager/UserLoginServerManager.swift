//
//  UserLoginServerManager.swift
//  Main
//
//  Created by 朱佳杰 on 2017/7/4.
//

import Foundation
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import RouteManager
import DataBaseManager

open class UserLoginServerManager:BaseServerManager {
    
    public override init() {
        super.init()
        let _ = UserLoginRoute.init(method: .post, uri: "/login") { (request, response) in
            var jsonString = ""
            let DBManager = UserLoginDBManager()
            let params: Array = request.params() //post请求方式获取所有参数
            var realParam: [(String,String)] = []
            var data = [String:String]()
            for (index,(var key,var value)) in params.enumerated() {
                
                key += "="
                if (index == params.endIndex - 1){
                    value = "'" + value + "'"
                }else{
                    value = "'" + value + "'" + " and "
                }
               realParam.append((key,value))
            }
            let result = DBManager.selectDataBaseSQLwhere(tableName: "user_regist", columnAndValue: realParam)
            if (result.success){
                var resultArr = [[String:Any]]() //创建一个字典数组用于存储结果
                result.mysqlResult!.forEachRow (callback: { (row) in
                    data["user_id"] = row[0]
                    data["nickname"] = row[1]
                    data["telnum"] = row[2]
                    resultArr.append(["data":data]) //保存到字典内
                })
                if (resultArr.isEmpty){
                     jsonString = self.baseResponseBodyJSONData(status: 100, message: "失败,账号或密码不正确", data: [])
                }else {
                     jsonString = self.baseResponseBodyJSONData(status: 200, message: "成功", data: data)
                }
                
            }else {
                jsonString = self.baseResponseBodyJSONData(status: 100, message: result.errorMsg, data: ["无数据"])
            }
            response.setBody(string: jsonString)
            response.completed()
        }
    }
}
