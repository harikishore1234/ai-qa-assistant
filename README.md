# AI Q&A Assistant

A simple yet professional AI-powered Question Answering application built as a technical assessment for Mackcliff Automation Engineer role.

##  Features

-  **User Input**: Clean interface to submit questions
-  **AI-Powered Answers**: Uses OpenAI's GPT-4o-mini model for intelligent responses
-  **Fast API Backend**: Modern Python FastAPI framework
-  **Responsive UI**: Beautiful, mobile-friendly frontend
-  **Error Handling**: Robust error management and user feedback
-  **Copy Functionality**: Easy to copy and share answers
-  **Environment Configuration**: Secure API key management using .env files

##  Tech Stack

| Component | Technology |
|-----------|-----------|
| **Backend** | Python, FastAPI |
| **Frontend** | HTML, CSS, JavaScript |
| **AI Engine** | OpenAI API (GPT-4o-mini) |
| **Server** | Uvicorn |
| **CORS** | FastAPI Middleware |

## Project Structure

```
ai-qa-assistant/
├── backend/
│   ├── main.py              # FastAPI application with AI integration
│   └── requirements.txt      # Python dependencies
├── frontend/
│   ├── index.html           # Main HTML interface
│   ├── style.css            # Styling and animations
│   └── script.js            # Frontend logic and API calls
└── README.md                # This file
```

##  Quick Start

### Prerequisites
- Python 3.8+
- OpenAI API Key (get it from https://platform.openai.com/account/api-keys)
- Any modern web browser

### Step 1: Get OpenAI API Key

1. Go to [OpenAI Platform](https://platform.openai.com/account/api-keys)
2. Sign up or log in to your account
3. Click "Create new secret key"
4. Copy and save the key securely

** Important**: Never share your API key or commit it to version control!

### Step 2: Setup Backend

1. Navigate to the backend directory:
   ```bash
   cd backend
   ```

2. Create a `.env` file in the backend directory:
   ```bash
   # Create .env file (Windows Command Prompt)
   echo OPENAI_API_KEY=your_actual_api_key_here > .env
   
   # Create .env file (PowerShell on Windows)
   @"
   OPENAI_API_KEY=your_actual_api_key_here
   "@ | Out-File -Encoding UTF8 .env
   
   # Create .env file (Linux/Mac)
   echo "OPENAI_API_KEY=your_actual_api_key_here" > .env
   ```

   Replace `your_actual_api_key_here` with your actual OpenAI API key.

   **Example .env file:**
   ```
   OPENAI_API_KEY=sk-proj-xxxxxxxxxxxxxxxxxxxxxxxxxxxx
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Run the FastAPI server:
   ```bash
   uvicorn main:app --reload
   ```

   You should see output like:
   ```
   INFO:     Started server process [1234]
   INFO:     Waiting for application startup.
   INFO:     Application startup complete.
   INFO:     Uvicorn running on http://127.0.0.1:8000
   ```

### Step 3: Run Frontend

1. In a new terminal/command prompt, navigate to the frontend directory:
   ```bash
   cd frontend
   ```

2. Start a simple HTTP server:
   
   **Windows (PowerShell):**
   ```bash
   python -m http.server 8001
   ```
   
   **Linux/Mac:**
   ```bash
   python3 -m http.server 8001
   ```

3. Open your browser and go to:
   ```
   http://localhost:8001
   ```

   Or simply open `index.html` directly in your browser (if running on localhost:8001 via server)

### 🎉 You're All Set!

Now you can:
1. Type a question in the textarea
2. Click "Ask AI" button
3. Get instant AI-powered answers
4. Copy the answer using the "Copy Answer" button

##  Usage Tips

**Example Questions:**
- "Explain quantum computing in simple terms"
- "How does photosynthesis work?"
- "What is machine learning?"
- "Provide a Python example for sorting a list"

**Keyboard Shortcut:**
- Press `Ctrl + Enter` to submit your question quickly

##  Security Best Practices

-  API key stored in `.env` file locally
-  `.env` file should be added to `.gitignore`
-  CORS configured for local development
-  Input validation on both frontend and backend
-  Error handling without exposing sensitive data

### Example .gitignore

Create a `.gitignore` file in the project root:
```
.env
__pycache__/
*.pyc
.DS_Store
node_modules/
.venv/
venv/
```

## 📊 API Endpoints

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/` | GET | Health check |
| `/ask` | POST | Submit question and get AI answer |

### Request Format (POST /ask)

```json
{
  "question": "What is artificial intelligence?"
}
```

### Response Format

```json
{
  "answer": "Artificial intelligence (AI) is...",
  "status": "success"
}
```

### Error Response

```json
{
  "error": "Error message here",
  "status": "error"
}
```

##  Troubleshooting

### "Cannot connect to the API"
- Ensure the FastAPI server is running on `http://127.0.0.1:8000`
- Check that no firewall is blocking the connection
- Verify the backend is started: `uvicorn main:app --reload`

### "OPENAI_API_KEY environment variable not set"
- Create a `.env` file in the backend folder
- Add your API key: `OPENAI_API_KEY=sk-...`
- Restart the FastAPI server

### "OpenAI API Error"
- Verify your API key is correct and active
- Check if you have sufficient API credits
- Ensure the model name is correct (gpt-4o-mini)

### CORS Error
- Ensure FastAPI is running with CORS middleware enabled
- Check that the API URL in `script.js` matches your backend URL

## 📈 Code Structure & Assessment Criteria

### 1. **Practical AI Implementation** ✅
- OpenAI API integration with proper error handling
- GPT-4o-mini model for accurate responses
- Environment-based configuration for flexibility

### 2. **Code Structure** ✅
- Clean separation of backend (FastAPI) and frontend (HTML/CSS/JS)
- Modular code with clear function responsibilities
- Professional project organization

### 3. **Output Relevance** ✅
- AI configured with system prompts for accurate answers
- Input validation to ensure quality questions
- Response formatting for readability

## 📦 Deployment Considerations

For production deployment:
1. Use environment variables for API keys (never hardcode)
2. Add request rate limiting
3. Implement user authentication if needed
4. Use HTTPS for secure communication
5. Deploy on cloud platforms (AWS, Heroku, Google Cloud, etc.)
6. Add logging and monitoring
