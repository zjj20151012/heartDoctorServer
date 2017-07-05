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
    
    override public func selectDataBaseSQLwhere(tableName: String, keyValue: [(String, String)]) -> (success: Bool, mysqlResult: MySQL.Results?, errorMsg: String) {
        print(keyValue)
        return (true,nil,"子类方法")
    }
    
}

