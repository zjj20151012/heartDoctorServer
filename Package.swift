// Generated automatically by Perfect Assistant Application
// Date: 2017-06-30 03:08:29 +0000
import PackageDescription
let package = Package(
	name: "heartDoctorServer",
    targets: [
        Target(name: "Main", dependencies: ["ServerManager"]),
        Target(name: "ServerManager", dependencies: ["DataBaseManager","RouteManager"]),
        Target(name: "RouteManager", dependencies: ["DataBaseManager"])
    ],
	dependencies: [
		.Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", versions: Version(0,0,0)..<Version(10,0,0)),
		.Package(url: "https://github.com/PerfectlySoft/Perfect-MySQL.git", versions: Version(0,0,0)..<Version(10,0,0)),
		.Package(url: "https://github.com/PerfectlySoft/Perfect-Mustache.git", versions: Version(0,0,0)..<Version(10,0,0)),
	]
)
