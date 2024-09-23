import { Router, Request, Response } from "express";
import { generateOpenAIResponsesController } from "../controllers/generate_openAI_controller";

const openAiRouter = Router();

openAiRouter.post("/", generateOpenAIResponsesController);

export default openAiRouter;