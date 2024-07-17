# CI/CD Pipeline To Docker Hub
This repository demonstrates the setup of a CI/CD pipeline that automatically builds and pushes Docker images to Docker Hub upon each commit.

## Overview
The primary goal of this test repository is to showcase a basic CI/CD pipeline that ensures Docker images are built and pushed to Docker Hub whenever changes are committed to the repository.

## CI/CD Workflow

### Continuous Integration

The continuous integration process involves building the Docker image whenever a commit is made to the repository. It includes automated testing and checks to maintain code reliability.

### Continuous Deployment to Docker Hub

Continuous deployment to Docker Hub ensures that the built Docker image is automatically pushed to a specified Docker Hub repository.

## Setup
- Go to “Settings” and go to “Secret and Variables” in the left panel.
- Choose the “Actions” and then click on “New Repository Secret”.
- Add your docker hub username and passwords in the repository secret with the name:
DOCKER_USERNAME
DOCKER_PASSWORD
- Go to actions and click on “set up a workflow yourself” highlighted in blue at the top.
- A main.yaml file will be opened. Inside the main.yaml file, copy the following code:

```yaml
name: Publish Docker image

on:
  push:
    branches: ['main']

jobs:
  push_to_registry:
    name: Push Docker image to Docker Hub
    runs-on: ubuntu-latest
    steps:
      - name: Check out the repo
        uses: actions/checkout@v3
      
      - name: Log in to Docker Hub
        uses: docker/login-action@f054a8b539a109f9f41c372932f1ae047eff08c9
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}
      
      - name: Extract metadata (tags, labels) for Docker
        id: meta
        uses: docker/metadata-action@98669ae865ea3cffbcbaa878cf57c20bbf1c6c38
        with:
          images: shubhid/testpython
      
      - name: Build and push Docker image
        uses: docker/build-push-action@ad44023a93711e3deb337508980b4b5e9bcdc5dc
        with:
          context: .
          push: true
          file: ./Dockerfile
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}

```
<b> Note:</b> Make sure you change your docker hub username, image name and your dockerfile location. Above is an example GitHub Actions workflow for building and pushing a Docker image to Docker Hub. This workflow is triggered on each commit.

- After adding the code, commit the changes in the main.yaml file.
- Go to “Actions” and see whether the file is being created or not. If yes, then the instructions that are included in the yaml file will be executed and the image will be pushed to the docker hub.
- Login to your docker hub and check whether the image is pushed or not.
- Now if that works fine, make some changes in the dockerfile.
- Go to dockerfile, click on edit and then change it. Eg: change the port from 3000 to 4000.
- Go to “Actions”. You can see that the dockerfile will be updating automatically and the updated image will be pushed to the docker hub.

## Benefits
- Automated Docker Image Builds: Commits automatically initiate Docker image builds, reflecting the latest changes.
- Streamlined Docker Image Pushes: Images are pushed to Docker Hub automatically, simplifying the deployment process.

  ![diagram-export-7-15-2024-11_22_59-PM](https://github.com/user-attachments/assets/c096162b-b53a-4a5e-b761-4f9a8468a578)

