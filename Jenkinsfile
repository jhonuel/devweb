pipeline {
    agent { label 'server' }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhubpass')
    }

    stages {
        stage('Build and Deploy') {
            steps {
                script {
                    echo "Clonando el repositorio..."
                    git 'https://github.com/jhonuel/devweb.git'

                    echo "Construyendo la imagen Docker..."
                    sh "docker build -t \${REGISTRY}/nodeapp_test:latest ."

                    echo "Subiendo la imagen al registro Docker..."
                    sh "docker login -u \${DOCKER_USERNAME} -p \${DOCKER_PASSWORD}"
                    sh "docker push \${REGISTRY}/nodeapp_test:latest"

                    echo "Desplegando en el servidor..."
                    sh "docker run -d --name nodeapp -p 8080:8080 \${REGISTRY}/nodeapp_test:latest"
                }
            }
        }
    }
}
