"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const http_1 = __importDefault(require("http"));
const cors_1 = __importDefault(require("cors"));
const dotenv_1 = __importDefault(require("dotenv"));
const body_parser_1 = __importDefault(require("body-parser"));
const routes_1 = __importDefault(require("./routes/routes"));
const app = (0, express_1.default)();
const server = http_1.default.createServer(app);
app.use((0, cors_1.default)());
app.use(body_parser_1.default.json());
app.use(body_parser_1.default.urlencoded({ extended: true }));
app.set("PORT", 3000);
app.set("BASE_URL", "localhost");
dotenv_1.default.config(); // configure env file
app.use("/api/v1", routes_1.default);
try {
    const port = app.get("PORT");
    server.listen(port, () => {
        console.log(`Server is listening on port ${port}`);
    });
}
catch (err) {
    console.log(err);
}
exports.default = server;
// export default:
// export: This keyword is used to export variables, functions, classes, or any other entities from a module.
// default: Indicates that the exported entity is the default export of the module. A module can only have one default export.
// server:
// server is the name of the entity being exported. This could be a variable, function, class, or object. In the context of a Node.js HTTP server, server is typically an instance of an HTTP server created with http.createServer().
// Usage:
// By exporting server as the default export, you allow other files to import this specific entity without having to use curly braces for named imports.
