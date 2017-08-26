import PackageDescription

let package = Package(
	name: "Today-News-Admin",
	targets: [

        Target(name: "Application", dependencies: ["Server"]),
        Target(name: "Common", dependencies: []),
        Target(name: "Config", dependencies: []),
        Target(name: "DataBase", dependencies: ["Config"]),
        Target(name: "Model", dependencies: ["DataBase","Common","Config"]),
        Target(name: "Server", dependencies: ["Route", "DataBase","Config"]),
        Target(name: "Handler", dependencies: ["Common", "DataBase","Model","Config"]),
        Target(name: "Route", dependencies: ["Handler", "Common", "DataBase"])
    ],
	dependencies: [
        .Package(
            url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git",
            majorVersion: 2),
        .Package(
            url:"https://github.com/PerfectlySoft/Perfect-MongoDB.git",
            majorVersion: 2, minor: 0),
        .Package(
            url:"https://github.com/PerfectlySoft/PerfectLib.git",
            majorVersion: 2, minor: 0),
        .Package(url: "https://github.com/PerfectlySoft/Perfect-Mustache.git", majorVersion: 2, minor: 0)
    ]
)
