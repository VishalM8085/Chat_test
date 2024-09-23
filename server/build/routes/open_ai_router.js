"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const generate_openAI_controller_1 = require("../controllers/generate_openAI_controller");
const openAiRouter = (0, express_1.Router)();
openAiRouter.post("/", generate_openAI_controller_1.generateOpenAIResponsesController);
exports.default = openAiRouter;
