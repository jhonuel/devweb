pipeline {
    agent { label 'server' }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
    }

    stages {
        stage('Build and Deploy') {
            steps {
                script {
                    echo "Clonando el repositorio..."
                    git 'https://github.com/jhonuel/devweb.git'

                    echo "Construyendo la imagen Docker..."
                    sh "docker build -t \${REGISTRY}/web-server-app ."

                    echo "Subiendo la imagen al registro Docker..."
                    sh "docker login -u \${DOCKER_USERNAME} -p \${DOCKER_PASSWORD}"
                    sh "docker push \${REGISTRY}/web-server-app:latest"

                    echo "Desplegando en Kubernetes..."
                    withEnv(["KUBECONFIG=/root/kube_config_cluster.yml"]) {
                        sh "kubectl apply -f deployment.yaml"
                    }
                }
            }
        }
    }
}