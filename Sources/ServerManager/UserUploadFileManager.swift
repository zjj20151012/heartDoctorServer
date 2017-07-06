//
//  UserUploadFileManager.swift
//  PerfectLib
//
//  Created by 朱佳杰 on 2017/7/6.
//

import Foundation
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import RouteManager
import DataBaseManager

//访问权限 open > public > interal > fileprivate > private

open class UserUploadFileManager:BaseServerManager {
    public override init(){
        super.init()
        let _ = UserUploadFileRoute.init(method: .post, uri: "/upload") { (request, response) in
            var jsonString = ""
            // 通过操作fileUploads数组来掌握文件上传的情况
            // 如果这个POST请求不是分段multi-part类型，则该数组内容为空
            var values = [String:Any]()
            if let uploads = request.postFileUploads, uploads.count > 0 {
                // 创建一个字典数组用于检查已经上载的内容
                var fileDict = [[String:Any]]()
                // 创建路径用于存储已上传文件
                let fileDir = Dir(Dir.workingDir.path + "files")
                do {
                    try fileDir.create()
                } catch {
                    print(error)
                }
                for upload in uploads {
                    fileDict.append([
                        "fieldName": upload.fieldName,  //字段名
                        "contentType": upload.contentType, //文件内容类型
                        "fileName": upload.fileName,    //文件名
                        "fileSize": upload.fileSize,    //文件尺寸
                        "tmpFileName": upload.tmpFileName   //上载后的临时文件名
                        ])
                    
                    // 将文件转移走，如果目标位置已经有同名文件则进行覆盖操作。
                    let thisFile = File(upload.tmpFileName)
                    do {
                        let _ = try thisFile.moveTo(path: fileDir.path + upload.fileName, overWrite: true)
                    } catch {
                        print(error)
                    }
                    print(fileDir.path + upload.fileName)
                }
                values["files"] = fileDict
                values["count"] = fileDict.count
            }
            if (values.isEmpty){
                jsonString = self.baseResponseBodyJSONData(status: 100, message: "失败", data: "文件上传失败")
            }else{
                jsonString = self.baseResponseBodyJSONData(status: 200, message: "成功", data: values)
            }
            print(values)
            response.setBody(string: jsonString)
            response.completed()
        }
    }
}

