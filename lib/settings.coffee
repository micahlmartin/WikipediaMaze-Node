module.exports = 
	webServerPort: process.env.PORT || 3001
	mongo: 
		host: process.env["MONGO_HOST"] || "127.0.0.1"
		port: parseInt(process.env["MONGO_PORT"]) || 27017
		username: process.env["MONGO_USERNAME"] 
		password: process.env["MONGO_PASSWORD"]
		db: process.env["MONGO_DB"] || "wikipediamaze"
	debugLogging: process.env["DEBUG_LOGGING"] || true,
	infoLogging: process.env["INFO_LOGGING"] || true