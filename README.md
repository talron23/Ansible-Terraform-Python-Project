# Daily Horoscope App

## Overview

The project is a Daily Horoscope web application that offers horoscope readings based on users' zodiac signs. What sets this project apart is the profound automation achieved through Terraform.

Every aspect of the application's deployment, from creating AWS resources, including the web server, to dynamically provisioning Ansible control host, is seamlessly automated with Terraform code.

Key management, such as the generation and assignment of SSH keys to EC2 instances, is effortlessly handled within the same Terraform workflow. This end-to-end automation eliminates manual intervention, minimizes errors, and significantly accelerates the deployment cycle.

Using multiple technologies and all within the same terraform workflow - Python, Nginx and Flask, the result is a web application deployed on AWS that delivers daily horoscope reading, all thanks to the power of Terraform with one click of # terraform apply.


## Project Components

### Python
- **Flask Web Application**: The core of the project is built using Python and the Flask web framework. Flask allows us to create a lightweight yet powerful web application that serves horoscope data to users.

### Nginx
- **Reverse Proxy Server**: Nginx is used as a reverse proxy server to efficiently handle incoming web requests and serve the Flask application. 

### Flask
- **Web Application**: The Flask web application offers two main features: 
  - A user-friendly interface to select a zodiac sign and receive daily horoscope readings.
  - A RESTful API endpoint for programmatically retrieving horoscopes.

### Terraform
- **Infrastructure as Code**: Terraform is employed to manage the cloud infrastructure. It automates the provisioning of AWS resources, including the EC2 instance where the Flask app and Nginx are deployed, as well as security groups for network access. The goal is to showcase the power of infrastructure automation and make deployment a breeze.

### Ansible
- **Configuration Management**: Ansible is used for automated configuration management and application deployment. It ensures that the Flask app is correctly configured, and it manages the deployment of the application code.

### AWS
- **Cloud Hosting**: The project leverages Amazon Web Services (AWS) for cloud hosting. AWS provides scalable, reliable, and secure infrastructure for deploying the web application. 

## Project Goals

The primary goal of the Daily Horoscope App project is to create a user-friendly and automated platform for accessing daily horoscope readings. By utilizing Python, Flask, Nginx, Terraform, and Ansible, we aim to:

- Provide a simple and intuitive web interface for users to select their zodiac signs and receive personalized horoscope readings.
- Showcase the power of infrastructure as code with Terraform, enabling easy and consistent deployment of the web application to AWS.
- Highlight the importance of automated configuration management and deployment with Ansible for seamless and reliable application updates.

## Project Structure

- `app.py`: The main Flask application for serving horoscopes.
- `nginx.conf`: Nginx configuration file for web server settings.
- `Terraform/`: Terraform configuration for provisioning AWS infrastructure.
- `Ansible/`: Ansible playbooks for configuring and deploying the Flask application.
- `static/`: Static files, including CSS, JavaScript, and zodiac sign images.
- `templates/`: HTML template for the web interface.

## Getting Started

To quickly get started with the Daily Horoscope App, you'll need to have Terraform installed on your workstation. Follow these steps to deploy the project on AWS:

1. **Install Terraform**:
   If you don't have Terraform installed, you can download it from the [official website](https://www.terraform.io/downloads.html) and follow the installation instructions for your platform.

2. **Configure AWS Credentials**:
   Ensure you have your AWS access key and secret access key ready. You can configure these credentials using the AWS Command Line Interface (`aws configure`) or by setting environment variables (`AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`).

3. **Deploy the Infrastructure**:
   Clone this GitHub repository to your local machine using Git:
   ```bash
   git clone https://github.com/talron23/Ansible-Terraform-Python-Project.git
   cd Ansible-Terraform-Python-Project

4. **Initialize Terraform**:
   # terraform init

5. **Configure AWS Credentials**:
   # terraform apply

6. **Access the Web Application**:
   After the Terraform deployment is complete, you will receive information about the resources created, including the public IP address of the EC2 instance. You can access the web application by entering the EC2 instance's IP address in your web browser.


## Contact
For questions or feedback, please contact me at [tal00ron@gmail.com].
