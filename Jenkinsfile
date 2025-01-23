pipeline {
    agent any
    environment {
        registry = "jhonuel/devweb"
        registryCredential = 'dockerhubpass'
        dockerImage = ''
    }
    
    stages {
        stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/devmain']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/jhonuel/devweb.git']]])
            }
        }
        
        stage('Install Docker') {
            steps {
                sh '''
                if ! [ -x "$(command -v docker)" ]; then
                    echo "Docker is not installed. Installing Docker..."
                    curl -fsSL https://get.docker.com -o get-docker.sh
                    sh get-docker.sh
                    sudo usermod -aG docker $USER
                    newgrp docker
                else
                    echo "Docker is already installed"
                fi
                '''
            }
        }
        
        stage('Building image') {
            steps {
                script {
                    dockerImage = docker.build registry
                }
            }
        }
        
        stage('Upload Image') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
