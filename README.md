# LLM Engineering with Ollama - Local AI Models

This repository contains a Jupyter notebook that demonstrates how to connect to and use **Ollama** for running Large Language Models (LLMs) locally, as an alternative to paid APIs like OpenAI. This project is part of an LLM Engineering course assignment focused on building a webpage summarizer using local open-source models.

## 🎯 Project Overview

This project teaches you how to:
- Run open-source LLMs locally using Ollama
- Connect to Ollama using multiple approaches (HTTP requests, ollama package, OpenAI client)
- Build a webpage summarizer without relying on paid APIs
- Experiment with different models including Llama 3.2 and DeepSeek reasoning models

## 🔥 Benefits of Using Ollama

**Advantages:**
- ✅ **No API charges** - completely free and open-source
- ✅ **Data privacy** - all processing happens locally on your machine
- ✅ **No internet dependency** - works offline once models are downloaded

**Trade-offs:**
- ⚠️ **Less powerful** than frontier models like GPT-4
- ⚠️ **Requires local compute resources** (RAM and storage)

## 📋 Prerequisites

Before you begin, ensure you have:
- **Python 3.8+** installed
- **Conda** or **Miniconda** installed
- **At least 8GB RAM** (16GB+ recommended for larger models)
- **5-10GB free disk space** for model downloads
- **Internet connection** for initial setup and model downloads

## 🚀 Installation Guide

### Step 1: Install Ollama

1. **Visit [ollama.com](https://ollama.com)** and download the installer for your operating system
2. **Install Ollama** following the platform-specific instructions:
   - **macOS**: Download and run the `.dmg` installer
   - **Windows**: Download and run the `.exe` installer  
   - **Linux**: Follow the installation script on the website

3. **Verify Ollama is running**:
   - Open your browser and go to [http://localhost:11434/](http://localhost:11434/)
   - You should see the message: `Ollama is running`

4. **If Ollama is not running**:
   ```bash
   # Start Ollama server (in one terminal)
   ollama serve
   
   # Pull the required model (in another terminal)
   ollama pull llama3.2
   ```

### Step 2: Set Up Python Environment

1. **Clone this repository**:
   ```bash
   git clone <repository-url>
   cd LLM-2-Ollama_OpenAI
   ```

2. **Create conda environment from yml file**:
   ```bash
   conda env create -f environment.yml
   ```

3. **Activate the environment**:
   ```bash
   conda activate ollama-llm-env
   ```

4. **Install Jupyter Lab (if not included)**:
   ```bash
   conda install jupyterlab
   ```

### Step 3: Download Required Models

```bash
# Download the main model (about 2GB)
ollama pull llama3.2

# Optional: Download smaller model if your machine is slow
ollama pull llama3.2:1b

# Optional: Download DeepSeek reasoning model (experimental)
ollama pull deepseek-r1:1.5b
```

## 🏃‍♂️ Running the Project

1. **Start Jupyter Lab**:
   ```bash
   jupyter lab
   ```

2. **Open the notebook**:
   - Navigate to `Ollama-Connect.ipynb`
   - Run cells sequentially from top to bottom

3. **Verify everything works**:
   - The first few cells should successfully connect to Ollama
   - You should see responses from the local LLM models

## 📚 Notebook Structure and Explanation

### Section 1: Basic Setup and Imports
- **Purpose**: Import required libraries for web scraping and LLM interaction
- **Libraries**: `requests`, `BeautifulSoup`, `ollama`, `openai`

### Section 2: Direct HTTP API Calls
- **What it does**: Shows how to make direct HTTP requests to Ollama's REST API
- **Endpoint**: `http://localhost:11434/api/chat`
- **Format**: Uses the same message format as OpenAI (role: user/assistant)

### Section 3: Using the Ollama Python Package
- **What it does**: Demonstrates the cleaner `ollama` Python package
- **Advantage**: More elegant and pythonic than raw HTTP calls
- **Installation**: Included in the environment.yml

### Section 4: OpenAI Client Library with Ollama
- **What it does**: Shows how to use OpenAI's client library to connect to Ollama
- **Why this works**: Ollama implements OpenAI-compatible endpoints
- **Base URL**: `http://localhost:11434/v1`
- **Advantage**: Drop-in replacement for OpenAI code

### Section 5: DeepSeek Reasoning Model
- **What it does**: Demonstrates advanced reasoning capabilities
- **Model**: `deepseek-r1:1.5b` (1.5B parameter reasoning model)
- **Special feature**: Shows "thinking" process in `<think>` tags

### Section 6: Your Assignment
- **Goal**: Build a webpage summarizer using local models
- **Task**: Integrate Day 1 project code with Ollama
- **Options**: Use any of the three connection methods shown above

## 🛠️ Troubleshooting

### Common Issues and Solutions

**1. "Connection refused" errors:**
```bash
# Make sure Ollama is running
ollama serve
```

**2. "Model not found" errors:**
```bash
# Pull the required model
ollama pull llama3.2
```

**3. Slow performance:**
```bash
# Use smaller model variant
ollama pull llama3.2:1b
# Then change MODEL = "llama3.2" to MODEL = "llama3.2:1b" in the notebook
```

**4. Out of memory errors:**
- Close other applications
- Use smaller model variants (e.g., `llama3.2:1b`)
- Restart Ollama: `pkill ollama && ollama serve`

**5. Jupyter kernel issues:**
```bash
# Reinstall ipykernel in the conda environment
conda activate ollama-llm-env
conda install ipykernel
python -m ipykernel install --user --name ollama-llm-env
```

## 🔧 Model Options and Performance

| Model | Size | RAM Required | Speed | Quality |
|-------|------|-------------|-------|---------|
| `llama3.2:1b` | ~1.3GB | 4GB+ | Fast | Good |
| `llama3.2` | ~2.0GB | 8GB+ | Medium | Better |
| `llama3.2:3b` | ~2.0GB | 8GB+ | Medium | Better |
| `deepseek-r1:1.5b` | ~1.0GB | 4GB+ | Slow | High reasoning |

## 📝 Assignment Details

### Main Exercise: Webpage Summarizer
Your task is to create a webpage summarizer that:

1. **Takes a URL as input**
2. **Scrapes the webpage content** using BeautifulSoup
3. **Sends the content to Ollama** for summarization
4. **Returns a concise summary** of the webpage

### Implementation Options:
- Use direct HTTP calls to Ollama API
- Use the `ollama` Python package
- Use OpenAI client library with Ollama base URL

### Expected Workflow:
```python
# 1. Scrape webpage
url = "https://example.com"
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
content = soup.get_text()

# 2. Create summary prompt
messages = [{
    "role": "user", 
    "content": f"Please summarize this webpage content: {content}"
}]

# 3. Get summary from Ollama
# (Use any of the three methods shown in the notebook)
```

## 🌐 Useful Resources

- **Course Resources**: [LLM Engineering Resources](https://edwarddonner.com/2024/11/13/llm-engineering-resources/)
- **Ollama Documentation**: [https://ollama.com](https://ollama.com)
- **Available Models**: [Ollama Model Library](https://ollama.com/library)
- **DeepSeek Models**: [DeepSeek on Ollama](https://ollama.com/library/deepseek-r1)

## 🤝 Getting Help

If you encounter issues:
1. **Check the troubleshooting section** above
2. **Verify Ollama is running** at [http://localhost:11434/](http://localhost:11434/)
3. **Ensure models are downloaded** with `ollama list`
4. **Check the course resources** for additional help
5. **Contact the instructor** if problems persist

## 📄 License

This project is for educational purposes as part of an LLM Engineering course.

---

**Happy Learning! 🚀**

*Remember: This setup gives you the power to run AI models locally without any API costs or data privacy concerns!*