import express, {Express} from 'express'
import http from'http'
import cors from'cors'
import dotenv from 'dotenv'
import bodyParser from 'body-parser'
import router from './routes/routes'

const app: Express = express();
const server = http.createServer(app);

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));

app.set("PORT", 3000);
app.set("BASE_URL", "localhost");

dotenv.config(); // configure env file

app.use("/api/v1", router);

try {
    const port = app.get("PORT");
    server.listen(port, (): void => {
        console.log(`Server is listening on port ${port}`);
    })

} catch(err) {
    console.log(err);
}



export default server;


// export default:
// export: This keyword is used to export variables, functions, classes, or any other entities from a module.
// default: Indicates that the exported entity is the default export of the module. A module can only have one default export.
// server:

// server is the name of the entity being exported. This could be a variable, function, class, or object. In the context of a Node.js HTTP server, server is typically an instance of an HTTP server created with http.createServer().
// Usage:

// By exporting server as the default export, you allow other files to import this specific entity without having to use curly braces for named imports.


