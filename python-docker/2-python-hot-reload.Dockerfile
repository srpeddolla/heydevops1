# Use an official Python runtime as a parent image
FROM python:3.10

# Set the working directory in the container to /app
WORKDIR /app

# Copy the requirements file into the container at /app
COPY gunicorn_app/requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire gunicorn_app directory into the container at /app/gunicorn_app
COPY gunicorn_app /app/gunicorn_app
RUN ls -R /app

# Set PYTHONPATH to /app to ensure Python can find the module
ENV PYTHONPATH=/app

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Install additional tools for hot-reloading.
RUN pip install watchdog

# Run the application with hot-reload enabled
CMD ["watchmedo", "auto-restart", "--directory=.", "--pattern=*.py", "--recursive", "--", "python", "/app/gunicorn_app/server.py"]
