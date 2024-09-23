"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __asyncValues = (this && this.__asyncValues) || function (o) {
    if (!Symbol.asyncIterator) throw new TypeError("Symbol.asyncIterator is not defined.");
    var m = o[Symbol.asyncIterator], i;
    return m ? m.call(o) : (o = typeof __values === "function" ? __values(o) : o[Symbol.iterator](), i = {}, verb("next"), verb("throw"), verb("return"), i[Symbol.asyncIterator] = function () { return this; }, i);
    function verb(n) { i[n] = o[n] && function (v) { return new Promise(function (resolve, reject) { v = o[n](v), settle(resolve, reject, v.done, v.value); }); }; }
    function settle(resolve, reject, d, v) { Promise.resolve(v).then(function(v) { resolve({ value: v, done: d }); }, reject); }
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.generateOpenAIResponsesController = void 0;
const openai_1 = __importDefault(require("openai"));
const generateOpenAIResponsesController = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    var _a, e_1, _b, _c;
    try {
        const reqBody = req.body;
        const messages = reqBody["messages"];
        const openai = new openai_1.default({
            apiKey: process.env.OPENAI_API_KEY,
        });
        const stream = yield openai.chat.completions.create({
            model: "gpt-3.5-turbo",
            messages: messages,
            temperature: 1,
            max_tokens: 1024,
            top_p: 1,
            frequency_penalty: 0,
            presence_penalty: 0,
            response_format: {
                type: "text",
            },
            stream: true, // stream set to true
        });
        res.set({ "Content-type": "text/event-stream" });
        try {
            // res.set(...): This method sets the response headers for the HTTP response.
            //"Content-type": "text/event-stream": This is setting the response's content type to text/event-stream. This is a special MIME type used for Server-Sent Events (SSE), which allows the server to push updates to the client in real time over a single HTTP connection. By setting this content type, the client knows that the server will be sending data over time, in chunks, rather than all at once
            for (var _d = true, stream_1 = __asyncValues(stream), stream_1_1; stream_1_1 = yield stream_1.next(), _a = stream_1_1.done, !_a; _d = true) {
                _c = stream_1_1.value;
                _d = false;
                const chunk = _c;
                const data = chunk.choices[0].delta.content || "";
                const formattedData = `data: ${JSON.stringify({ data })}\n\n`;
                res.write(formattedData);
            }
        }
        catch (e_1_1) { e_1 = { error: e_1_1 }; }
        finally {
            try {
                if (!_d && !_a && (_b = stream_1.return)) yield _b.call(stream_1);
            }
            finally { if (e_1) throw e_1.error; }
        }
    }
    catch (e) {
        console.log(e);
        return res.status(500).json({ data: e });
    }
});
exports.generateOpenAIResponsesController = generateOpenAIResponsesController;
// Line 2: for await (const chunk of stream) {
// for await...of loop: This loop asynchronously iterates over each "chunk" of data from the stream.
// const chunk of stream: The stream is the data coming from OpenAI's API in real time. As each new part of the response is received, it’s processed inside this loop. This is because the response is streamed (i.e., it is sent in small parts as they are generated).
// The await keyword ensures that the loop waits for each chunk before moving on to the next one.
// Line 3: const data = chunk.choices[0].delta.content || "";
// chunk.choices[0].delta.content: Each chunk received from the stream contains a structure, and this accesses the specific part of the data where the text from the model's response is located. The choices[0].delta.content refers to the incremental (delta) updates in the streamed data from OpenAI's response.
// choices[0] refers to the first choice of completion (in cases where multiple completions are generated, which is common).
// delta refers to the portion of the response that is being streamed incrementally, and content is the actual text generated so far.
// || "": This is a fallback in case chunk.choices[0].delta.content is null or undefined. If there is no content in the chunk, an empty string ("") will be used.
// Line 4: const formattedData = \data: ${JSON.stringify({ data })}\n\n`;`
// formattedData: This variable stores the formatted response data.
// data: ${}: This is using a template literal to create a string that starts with data: (which is a required part of the Server-Sent Events (SSE) protocol for sending event data). The SSE protocol expects data to be sent in this format.
// JSON.stringify({ data }): This converts the data (the content from OpenAI's response) into a JSON string. Wrapping the data in { data } ensures that it’s sent as a JSON object, so the client can easily parse it.
// \n\n: The two newlines (\n\n) are part of the Server-Sent Events (SSE) specification, indicating the end of a data chunk. Each event in SSE should be followed by two newlines to indicate to the client that this is the complete data for one message.
// Line 5: res.write(formattedData);
// res.write(formattedData): This sends the formattedData to the client immediately, without closing the connection. This is how data is streamed to the client in chunks. Each time the server has new data, it pushes it to the client through this method. The client (such as a web browser) receives the data as soon as it's available.
