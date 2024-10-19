# ChatFlowAI

ChatFlowAI is an innovative chatbot application that combines **Node.js**, **Express.js**, and the **OpenAI API** to deliver a powerful and engaging user experience. With real-time chat capabilities and intelligent responses, ChatFlowAI provides a seamless interaction platform through a cross-platform Flutter frontend.

## Features

- **Real-Time Interaction**: Enjoy instantaneous responses, making conversations fluid and dynamic.
- **Intelligent AI Responses**: Powered by the OpenAI API, the chatbot understands user queries and provides contextually relevant answers.
- **Streaming Responses**: Messages are generated in stream form, enabling users to see responses as they are being crafted. The application uses a for-await-of loop to iterate through each chunk of data received from the OpenAI API. 
  - **Data Streaming**: As each new part of the response is received, it’s processed in real time. The structure of the stream allows the chatbot to generate responses incrementally, ensuring a more engaging conversation experience.
  - **Efficient Processing**: Each chunk contains the model's incremental updates, ensuring that responses are displayed in a timely manner. This allows users to perceive the conversation as it unfolds, making interactions more dynamic.
- **Cross-Platform Compatibility**: Available on smartphones, tablets, and desktops, ensuring a consistent user experience across devices.
- **User-Friendly Interface**: A sleek and intuitive design that makes navigation simple and enjoyable.
- **Server-Sent Events (SSE)**: Utilizes SSE for real-time updates, allowing for efficient and scalable communication between the server and client.

## Technologies Used

- **Frontend**: Flutter
- **Backend**: Node.js, Express.js
- **API**: OpenAI API
- **Communication**: Server-Sent Events (SSE)

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



