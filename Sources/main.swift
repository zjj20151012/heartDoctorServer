import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

// 创建HTTP服务器
let server = HTTPServer()

// 注册您自己的路由和请求／响应句柄
var routes = Routes()
routes.add(method: .get, uri: "/", handler: {
    request, response in
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html><title>hello world</title><body>hello world!</body></html>")
    response.completed()
}
)

// 将路由注册到服务器上
server.addRoutes(routes)

// 监听8081端口
server.serverPort = 8081

do {
    // 启动HTTP服务器
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("网络出现错误：\(err) \(msg)")
}

