//
//  UserLoginDBManager.swift
//  Main
//
//  Created by 朱佳杰 on 2017/7/4.
//

import Foundation
import MySQL
import RouteManager

open class UserLoginDBManager:BaseDBManager  {
    public override init() {
        super.init()
    }
    
    public override func selectDataBaseSQLwhere(tableName: String, columnAndValue: [(String,String)]) -> (success: Bool, mysqlResult: MySQL.Results?, errorMsg: String) {
        
        //这个函数返回一个元祖
        var sqlStr = ""

        if columnAndValue.isEmpty {
            return (false, nil, "数据为空")
        }
        
        for (key,value) in columnAndValue {
            if (key.isEmpty){
                return (false, nil, "SQL语句错误")
            }else if (value.isEmpty){
                return (false, nil, key + "的值为空")
            }else{
                sqlStr = sqlStr + key + value
            }
        }
        
         print(sqlStr)
        let SQL = "SELECT * FROM \(tableName) WHERE \(sqlStr)"
        return mysqlStatement(SQL)
        
    }
}

