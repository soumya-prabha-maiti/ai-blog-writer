# Base image
FROM python:3.11

# Set the working directory 
WORKDIR /app

# Install dependencies
COPY requirements.txt /app
RUN pip install --no-cache-dir --upgrade -r requirements.txt

# Copy the current directory contents into the container at /app
COPY . /app

# Create the uploads directory
RUN mkdir /app/models

# Set permissions for uploads directory
RUN chmod 777 /app/models

# Download the model to models directory
RUN wget -P /app/models https://huggingface.co/TheBloke/Llama-2-7B-Chat-GGML/resolve/main/llama-2-7b-chat.ggmlv3.q8_0.bin

# Expose port 7680
EXPOSE 7680

# Start the gunicorn server
CMD ["streamlit", "run", "app.py", "--server.port", "7680"]

