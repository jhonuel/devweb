pipeline {
    agent { label 'server' }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhubpass') // Credenciales de DockerHub
        REGISTRY = "docker.io"                               // Registro Docker (puede cambiar según necesidad)
        IMAGE_NAME = "jhonuel/devweb"                        // Nombre de la imagen
    }

    stages {
        stage('Clonar Repositorio') {
            steps {
                script {
                    echo "Clonando el repositorio desde GitHub..."
                    git 'https://github.com/jhonuel/devweb.git'
                }
            }
        }

        stage('Construir Imagen Docker') {
            steps {
                script {
                    echo "Construyendo la imagen Docker..."
                    sh "docker build -t ${REGISTRY}/${IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Subir Imagen al Registro') {
            steps {
                script {
                    echo "Iniciando sesión en DockerHub..."
                    sh "docker login -u ${DOCKERHUB_CREDENTIALS_USR} -p ${DOCKERHUB_CREDENTIALS_PSW} ${REGISTRY}"
                    
                    echo "Subiendo la imagen al registro Docker..."
                    sh "docker push ${REGISTRY}/${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Desplegar Imagen') {
            steps {
                script {
                    echo "Desplegando la aplicación en el servidor..."
                    
                    // Elimina cualquier contenedor previo con el mismo nombre
                    sh "docker rm -f nodeapp || true"

                    // Ejecuta la nueva imagen
                    sh "docker run -d --name nodeapp -p 8080:8080 ${REGISTRY}/${IMAGE_NAME}:latest"
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completado con éxito. La aplicación está desplegada."
        }
        failure {
            echo "El pipeline falló. Revisa los registros para más detalles."
        }
    }
}
