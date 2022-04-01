pipeline {
    agent any

    tools { 
        maven 'my-maven' 
        jdk 'my-jdk' 
        terraform 'my-terraform'
    }
    parameters {
        string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')

    }
    environment {
        DOCKERHUB_CREDENTIALS=credentials('dockerhub')
        NAME = 'DINHLE'
        HOVATEN = 'DINHLEHOANG'
        abc = 'asdf'
    }
    stages {

        stage('Terraform') {

            steps {
                // sh 'sudo apt install maven'
                terraform init
                terraform plan
                terraform apply -auto-approve

            }
        }

    }
}
