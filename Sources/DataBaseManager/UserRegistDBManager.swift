//
//  UserRegistDBManager.swift
//  DataBaseManager
//
//  Created by 朱佳杰 on 2017/7/4.
//

import MySQL

open class UserRegistDBManager:BaseDBManager {
    public override init() {
        super.init()
    }
    
    public override func insertDatabaseSQL(tableName: String, columnAndValue: [(String, String)]) -> (success: Bool, mysqlResult: MySQL.Results?, errorMsg: String) {
        
        //这个函数返回一个元祖
        var columnStr = ""
        var valueStr = ""
        
        if columnAndValue.isEmpty {
            return (false, nil, "数据为空")
        }
        
        for (key,value) in columnAndValue {
            if (key.isEmpty){
                return (false, nil, "SQL语句错误")
            }else if (value.isEmpty){
                return (false, nil, key + "的值为空")
            }else{
                columnStr = columnStr + key
                valueStr = valueStr + value
            }
        }
        
        
        let SQL = "INSERT INTO \(tableName) (\(columnStr)) VALUES (\(valueStr))"
        return mysqlStatement(SQL)
    }
}

