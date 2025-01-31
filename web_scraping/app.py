import sys
import google.generativeai as ai

API_KEY = 'AIzaSyAMKoyibTdN-jRGbsoJfrKAaolyqCfBnAE'

ai.configure(api_key=API_KEY)
model = ai.GenerativeModel("gemini-pro")

def start_chat_with_ai(message: str):
    chat = model.start_chat()
    if message.lower() == 'bye':
        return 'Goodbye!'
    else:
        response = chat.send_message(message)
        return response.text

# Check if an argument is provided
if __name__ == "__main__":
    if len(sys.argv) > 1:  # Fix: Ensure at least one argument is passed
        message = sys.argv[1]
        response = start_chat_with_ai(message)
        print(response)
    else:
        print("Please provide a message as a command-line argument.")
        sys.exit(1)  # Exit with an error status