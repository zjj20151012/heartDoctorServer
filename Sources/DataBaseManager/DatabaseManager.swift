//
//  DatabaseManager.swift
//  heartDoctorServer
//
//  Created by 朱佳杰 on 2017/6/29.
//

import MySQL

//MARK: 数据库信息
let mysql_host     = "127.0.0.1"
let mysql_user     = "root"
let mysql_password = "951012zjj"
let mysql_database = "heartDoctor"

//MARK: 表信息
let table_account = "user_regist"

open class DatabaseManager {
    
    fileprivate var mysql: MySQL
    public init() {
        mysql = MySQL.init() //初始化mysql数据库
        guard connectedDataBase() else { //开启mysql数据库的连接
            return
        }
    }
    
    //MARK: 开启连接函数
    private func connectedDataBase() -> Bool {
        
        let connected = mysql.connect(host: mysql_host, user: mysql_user, password: mysql_password, db: mysql_database)
        guard connected else {
            print("数据库连接失败" + mysql.errorMessage())
            return false
        }
        print("数据库连接成功！")
        return true
        
    }
    
    //MARK: SQL语句
    //
    //
    // - Parameter sql: sql语句
    // - Returns: 返回元组(success:是否成功 result:结果)
    
    @discardableResult
    func mysqlStatement(_ sql: String) -> (success: Bool, mysqlResult: MySQL.Results?, errorMsg: String) {
        
        guard mysql.selectDatabase(named: mysql_database) else {            //指定database
            let msg = "未找到\(mysql_database)数据库"
            print(msg)
            return (false, nil, msg)
        }
        
        let successQuery = mysql.query(statement: sql)                      //sql语句
        guard successQuery else {
            let msg = "SQL失败: \(sql)"
            print(msg)
            return (false, nil, msg)
        }
        let msg = "SQL成功: \(sql)"
        print(msg)
        return (true, mysql.storeResults(), msg)                            //sql执行成功
        
    }
    
    /// 增
    ///
    /// - Parameters:
    ///   - tableName: 表
    ///   - key: 键  （键，键，键）
    ///   - value: 值  ('值', '值', '值')
    func insertDatabaseSQL(tableName: String, key: String, value: String) -> (success: Bool, mysqlResult: MySQL.Results?, errorMsg: String){
        
        let SQL = "INSERT INTO \(tableName) (\(key)) VALUES (\(value))"
        return mysqlStatement(SQL)
        
    }
    
    /// 删
    ///
    /// - Parameters:
    ///   - tableName: 表
    ///   - key: 键
    ///   - value: 值
    func deleteDatabaseSQL(tableName: String, key: String, value: String) -> (success: Bool, mysqlResult: MySQL.Results?, errorMsg: String) {
        
        let SQL = "DELETE FROM \(tableName) WHERE \(key) = '\(value)'"
        return mysqlStatement(SQL)
        
    }
    
    /// 改
    ///
    /// - Parameters:
    ///   - tableName: 表
    ///   - keyValue: 键值对( 键='值', 键='值', 键='值' )
    ///   - whereKey: 查找key
    ///   - whereValue: 查找value
    func updateDatabaseSQL(tableName: String, keyValue: String, whereKey: String, whereValue: String) -> (success: Bool, mysqlResult: MySQL.Results?, errorMsg: String) {
        
        let SQL = "UPDATE \(tableName) SET \(keyValue) WHERE \(whereKey) = '\(whereValue)'"
        return mysqlStatement(SQL)
        
    }
    
    /// 查所有
    ///
    /// - Parameters:
    ///   - tableName: 表
    ///   - key: 键
    func selectAllDatabaseSQL(tableName: String) -> (success: Bool, mysqlResult: MySQL.Results?, errorMsg: String) {
        
        let SQL = "SELECT * FROM \(tableName)"
        return mysqlStatement(SQL)
        
    }
    
    /// 查
    ///
    /// - Parameters:
    ///   - tableName: 表
    ///   - keyValue: 键值对
    func selectAllDataBaseSQLwhere(tableName: String, keyValue: String) -> (success: Bool, mysqlResult: MySQL.Results?, errorMsg: String) {
        
        let SQL = "SELECT * FROM \(tableName) WHERE \(keyValue)"
        return mysqlStatement(SQL)
        
    }
    
    //获取account_level表中所有数据
    public func mysqlGetHomeDataResult() -> [Dictionary<String, String>]? {
        
        let result = selectAllDatabaseSQL(tableName: table_account)
        var resultArray = [Dictionary<String, String>]()
        var dic = [String:String]()
        result.mysqlResult?.forEachRow(callback: { (row) in
            dic["user_id"] = row[0]
            dic["name"] = row[1]
            resultArray.append(dic)
        })
        return resultArray.isEmpty ? nil : resultArray
        
    }
}


