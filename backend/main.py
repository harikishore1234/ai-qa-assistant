from fastapi import FastAPI
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
import google.generativeai as genai
import os
from dotenv import load_dotenv

# Load environment variables from .env file
env_path = os.path.join(os.path.dirname(__file__), '.env')
load_dotenv(dotenv_path=env_path)

# Also read directly from .env as backup
if os.path.exists(env_path):
    with open(env_path) as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith('#') and '=' in line:
                key, value = line.split('=', 1)
                os.environ[key.strip()] = value.strip()

app = FastAPI()

# Allow frontend requests
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Initialize Gemini client with API key from environment variable
def get_gemini_model():
    api_key = os.getenv("GEMINI_API_KEY")
    if not api_key:
        raise ValueError("GEMINI_API_KEY environment variable not set")
    genai.configure(api_key=api_key)
    return genai.GenerativeModel('gemini-1.5-pro')

class Question(BaseModel):
    question: str

@app.post("/ask")
def ask_question(data: Question):
    """
    Process a user question and return an AI-generated answer.
    
    Args:
        data: Question object containing the user's question
    
    Returns:
        Dictionary with the AI's answer
    """
    if not data.question.strip():
        return {"error": "Question cannot be empty"}
    
    try:
        api_key = os.getenv("GEMINI_API_KEY")
        if not api_key:
            return {"error": "GEMINI_API_KEY not configured", "status": "error"}
        
        genai.configure(api_key=api_key)
        # List available models and use the first one
        models = genai.list_models()
        available_model = None
        for model in models:
            if 'generateContent' in model.supported_generation_methods:
                available_model = model.name.split('/')[-1]
                break
        
        if not available_model:
            available_model = 'gemini-pro'
        
        model = genai.GenerativeModel(available_model)
        response = model.generate_content(data.question)
        
        return {
            "answer": response.text,
            "status": "success"
        }
    except Exception as e:
        return {
            "error": str(e),
            "status": "error"
        }

@app.get("/")
def read_root():
    """Health check endpoint"""
    return {"message": "AI Q&A Assistant API is running"}
