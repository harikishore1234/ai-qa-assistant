const API_URL = "http://127.0.0.1:8000";

async function askQuestion() {
    const question = document.getElementById("question").value;
    const answerContainer = document.getElementById("answer-container");
    const errorContainer = document.getElementById("error-container");
    const btnText = document.getElementById("btn-text");
    const spinner = document.getElementById("spinner");
    const askBtn = document.querySelector(".ask-btn");

    // Validation
    if (!question.trim()) {
        showError("Please enter a question");
        return;
    }

    if (question.trim().length < 3) {
        showError("Question must be at least 3 characters long");
        return;
    }

    // Show loading state
    answerContainer.style.display = "none";
    errorContainer.style.display = "none";
    askBtn.disabled = true;
    btnText.style.display = "none";
    spinner.style.display = "inline-block";

    try {
        const response = await fetch(`${API_URL}/ask`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                question: question.trim()
            })
        });

        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        const data = await response.json();

        // Reset loading state
        btnText.style.display = "inline";
        spinner.style.display = "none";
        askBtn.disabled = false;

        if (data.status === "error" || data.error) {
            showError(data.error || "An error occurred while processing your question");
        } else {
            displayAnswer(data.answer);
        }
    } catch (error) {
        console.error("Error:", error);
        
        // Reset loading state
        btnText.style.display = "inline";
        spinner.style.display = "none";
        askBtn.disabled = false;

        if (error.message.includes("Failed to fetch")) {
            showError("Cannot connect to the API. Make sure the FastAPI server is running on http://127.0.0.1:8000");
        } else {
            showError("Error: " + error.message);
        }
    }
}

function displayAnswer(answer) {
    document.getElementById("answer").innerText = answer;
    document.getElementById("answer-container").style.display = "block";
    document.getElementById("error-container").style.display = "none";
    
    // Scroll to answer
    document.getElementById("answer-container").scrollIntoView({ behavior: "smooth" });
}

function showError(message) {
    document.getElementById("error-text").innerText = message;
    document.getElementById("error-container").style.display = "block";
    document.getElementById("answer-container").style.display = "none";
}

function copyAnswer() {
    const answerText = document.getElementById("answer").innerText;
    navigator.clipboard.writeText(answerText).then(() => {
        const copyBtn = document.querySelector(".copy-btn");
        const originalText = copyBtn.innerText;
        copyBtn.innerText = "✅ Copied!";
        setTimeout(() => {
            copyBtn.innerText = originalText;
        }, 2000);
    }).catch(err => {
        alert("Failed to copy: " + err);
    });
}

// Allow Enter key to submit question
document.addEventListener("DOMContentLoaded", () => {
    document.getElementById("question").addEventListener("keydown", (e) => {
        if (e.ctrlKey && e.key === "Enter") {
            askQuestion();
        }
    });
});
