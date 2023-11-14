# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-alpine
# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY build/libs/daemo-0.0.1-SNAPSHOT.jar /app/daemo.jar

# Expose the port the app runs on
EXPOSE 9090

# Run the application
CMD ["java", "-jar", "demo.jar"]
