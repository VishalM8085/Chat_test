import {Router} from "express";
import helloRouter from "./hello_router";
import openAiRouter from "./open_ai_router";

const router = Router();

router.use("/hello",helloRouter);

router.use("/generate_response", openAiRouter);

// only requests to /calendar/* will be sent to our "router"
//app.use('/calendar', router)

export default router;