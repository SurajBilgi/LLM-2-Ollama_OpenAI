#!/bin/bash

# LLM Engineering with Ollama - Setup Script
# This script automates the setup process for the Ollama project

set -e  # Exit on any error

echo "🚀 Setting up LLM Engineering with Ollama project..."
echo "=================================================="

# Check if conda is installed
if ! command -v conda &> /dev/null; then
    echo "❌ Conda is not installed. Please install Conda or Miniconda first."
    echo "   Visit: https://docs.conda.io/en/latest/miniconda.html"
    exit 1
fi

# Check if Ollama is installed
if ! command -v ollama &> /dev/null; then
    echo "❌ Ollama is not installed. Please install Ollama first."
    echo "   Visit: https://ollama.com"
    exit 1
fi

echo "✅ Prerequisites check passed!"

# Create conda environment
echo "📦 Creating conda environment from environment.yml..."
conda env create -f environment.yml

echo "🔄 Activating environment..."
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate ollama-llm-env

# Install Jupyter kernel
echo "🧠 Installing Jupyter kernel..."
python -m ipykernel install --user --name ollama-llm-env --display-name "Ollama LLM Environment"

# Check if Ollama is running
echo "🔍 Checking if Ollama is running..."
if curl -s http://localhost:11434/ | grep -q "Ollama is running"; then
    echo "✅ Ollama is running!"
else
    echo "⚠️  Ollama is not running. Starting Ollama server..."
    echo "   Note: Ollama will run in the background"
    ollama serve &
    sleep 5
    
    if curl -s http://localhost:11434/ | grep -q "Ollama is running"; then
        echo "✅ Ollama is now running!"
    else
        echo "❌ Could not start Ollama. Please start it manually with 'ollama serve'"
    fi
fi

# Download required models
echo "📥 Downloading required models..."
echo "   This may take several minutes depending on your internet connection..."

echo "   Downloading llama3.2 (main model - ~2GB)..."
ollama pull llama3.2

echo "   Downloading llama3.2:1b (lightweight model - ~1.3GB)..."
ollama pull llama3.2:1b

# Optional: Download DeepSeek model
read -p "🤔 Do you want to download the DeepSeek reasoning model? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "   Downloading deepseek-r1:1.5b (reasoning model - ~1GB)..."
    ollama pull deepseek-r1:1.5b
fi

echo ""
echo "🎉 Setup completed successfully!"
echo "=================================================="
echo ""
echo "📋 Next steps:"
echo "1. Activate the environment: conda activate ollama-llm-env"
echo "2. Start Jupyter Lab: jupyter lab"
echo "3. Open Ollama-Connect.ipynb and start learning!"
echo ""
echo "🔗 Quick links:"
echo "   - Ollama web interface: http://localhost:11434/"
echo "   - Available models: ollama list"
echo "   - Jupyter Lab: jupyter lab"
echo ""
echo "❓ Need help? Check the README.md file for troubleshooting tips!"
echo "" 