# ChatFlow AI 🤖💬  
**ChatFlow AI** is an intelligent chatbot application featuring a seamless and dynamic user interface, providing real-time chat capabilities and AI-driven responses. Whether you're seeking quick answers or engaging in meaningful conversations, ChatFlow AI ensures an interactive experience like no other.

## Technologies Used 🛠️  
- **Flutter** & **Dart**: 🌈 Powering a responsive and cross-platform UI that delivers smooth user experiences across Android and iOS devices.
- **Node.js** & **Express.js**: 🚀 The backbone of our robust backend, managing real-time data flow and request handling with ease.
- **TypeScript**: 📜 Enhancing code quality and maintainability, TypeScript brings type safety to the backend, making the entire system more reliable.
- **OpenAI API**: 🤖 The heart of ChatFlow AI, generating intelligent and context-aware responses powered by cutting-edge machine learning models.
- **Server-Sent Events (SSE)**: 📡 Leveraging SSE for real-time message streaming, ensuring users receive instant updates without delays.

## Features 🌟  
- **Real-Time Conversations**: 💬 Engage in live, fluid chat interactions with responses generated dynamically as you type.
- **Intelligent Responses**: 🧠 Our AI-powered chatbot delivers contextually relevant replies, elevating the quality of conversations.
- **Message Streaming**: 📈 Experience the thrill of seeing responses streamed in real-time, as they are generated incrementally.
- **Cross-Platform UI**: 📱 Built with Flutter, providing a consistent and seamless user interface across various platforms.
- **Interactive User Experience**: 🎉 Designed for ease of use, ensuring that users feel engaged and immersed in their conversations.
- **Instant Message Updates**: ⚡ Enjoy immediate visibility of sent messages and responses, fostering a natural conversational flow.
- **Server-Sent Events (SSE)**: 🔄 Our backend employs SSE to stream messages directly to the app, offering real-time updates without the need for continuous polling.
- **Hosted Backend API**: 🌐 The API, constructed using Node.js, Express.js, and TypeScript, interfaces with the OpenAI API to handle POST requests efficiently, allowing for rapid and intelligent responses.
- **Lightweight and Fast**: 🏎️ Optimized for performance, ensuring minimal loading times for an agile experience.
- **Easy Setup**: 🛠️ Quickly set up the app locally or utilize the hosted API for instant testing.

## API Overview 📡  
The ChatFlow AI backend is a well-crafted API built with **Node.js**, **Express.js**, and **TypeScript**. This architecture allows seamless communication with the **OpenAI API** to handle POST requests, facilitating quick and intelligent response generation. 

When a user sends a message, the backend processes this request, interacting with the OpenAI model to generate a relevant reply. The entire process is designed to be efficient, ensuring that users receive fast responses while enjoying the conversation.

## API Endpoint

The application uses the following API endpoint for generating responses using the POST method:

[https://chatflowai.onrender.com/api/v1/generate_response](https://chatflowai.onrender.com/api/v1/generate_response)


## Installation

To run the project locally, follow these steps:

```bash
# Clone the repository
git clone https://github.com/yourusername/ChatFlowAI.git
cd ChatFlowAI

# Setup Frontend
cd client
flutter pub get
flutter run



