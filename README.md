# ChatFlow AI 🤖💬  
**ChatFlow AI** is a cutting-edge chatbot application built with a responsive UI and integrated with advanced AI capabilities for real-time, interactive conversations. Powered by **OpenAI's GPT model**, this application provides intelligent, context-driven responses, ensuring a seamless and engaging user experience.

## Technologies Used 🛠️  
- **Flutter** & **Dart**: 🌐 Delivering a cross-platform UI with a single codebase, ensuring responsiveness and fluid interactions across Android and iOS.
- **Node.js** & **Express.js**: 🚀 A scalable backend server handling HTTP requests, efficiently routing incoming chat messages to the **OpenAI API** and returning responses via a RESTful architecture.
- **TypeScript**: 📜 Providing static typing to enhance code reliability, making the backend more predictable and maintainable with type-safe APIs.
- **OpenAI API**: 🤖 Integrating **GPT-based AI models** for generating intelligent, human-like responses based on the conversation context.
- **Server-Sent Events (SSE)**: 🔄 Streaming chat responses in real-time to ensure users see the messages being generated incrementally without delay.
- **BLoC State Management**: 🧠 Utilizing **BLoC (Business Logic Component)** to manage the app’s state efficiently, ensuring smooth interactions and predictable UI updates.

## Features 🌟  
- **Real-Time Conversations**: Enjoy smooth, real-time chat interactions, with responses generated as you type.
- **AI-Powered Responses**: Leveraging **OpenAI's GPT** for delivering contextually intelligent and dynamic responses based on your queries.
- **Message Streaming**: Chat responses are streamed in real-time via **Server-Sent Events (SSE)**, allowing you to see the text generated incrementally, ensuring conversational fluidity.
- **Cross-Platform UI**: Built with **Flutter**, ensuring a consistent and visually appealing user interface on both iOS and Android devices.
- **Interactive User Experience**: The app is designed with user-friendliness at its core, providing a fluid and engaging chat interface.
- **BLoC Pattern for State Management**: Ensures clean separation of logic and UI, leading to predictable and maintainable code.
- **Instant Message Updates**: Sent messages and responses appear immediately, supporting a seamless conversational flow.
- **Hosted API**: The application integrates a **hosted backend API** for fast and reliable response times, eliminating the need for backend setup.
- **Lightweight and Fast**: Optimized for performance, ensuring minimal loading times and efficient resource use.

## API Overview 📡  
The ChatFlow AI backend is a well-crafted API built with **Node.js**, **Express.js**, and **TypeScript**. This architecture allows seamless communication with the **OpenAI API** to handle POST requests, facilitating quick and intelligent response generation. 

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



