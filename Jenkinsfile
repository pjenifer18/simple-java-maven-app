pipeline {
    agent any
    environment {
        TMPDIR = '/tmp'
    }
    stages {
        stage('Build') {
            steps {
            
            sh 'mvn -B -DskipTests clean package'
            }
        }
        stage('Sonarscan') {
            steps{

            sh '/home/ec2-user/sonar-scanner-4.8.0.2856-linux/bin/sonar-scanner -Dsonar.login=squ_e4230a928edac1efd6c361ce83f92cb0a2a1f7d1'
            }
        }
        stage('Dockerbuild'){
			steps{
					sh 'sudo docker build -t simplejavamaven .'

			}
		}
        stage('Dockerpush') {
            steps{

                withCredentials([aws(credentialsId: 'aws-cli-creds', region: 'ap-southeast-1')]) {
                    sh 'aws ecr get-login-password --region ap-southeast-1 | sudo docker login --username AWS --password-stdin 314503617348.dkr.ecr.ap-southeast-1.amazonaws.com'
                    sh 'sudo docker tag simplejavamaven:latest 314503617348.dkr.ecr.ap-southeast-1.amazonaws.com/simplejavamaven:latest'
                    sh 'sudo docker push 314503617348.dkr.ecr.ap-southeast-1.amazonaws.com/simplejavamaven:latest'
                }
            }
        }
        stage('deploy-dockercompose'){
			steps{

				sh 'scp -i "/home/ec2-user/jenkins-jeni.pem" docker-compose.yml ec2-user@ec2-13-212-160-69.ap-southeast-1.compute.amazonaws.com:~/simplejavamaven'
				sh 'ssh -i "/home/ec2-user/jenkins-jeni.pem" ec2-user@ec2-13-212-160-69.ap-southeast-1.compute.amazonaws.com "cd ~/simplejavamaven; aws ecr get-login-password --region ap-southeast-1 | sudo docker login --username AWS --password-stdin 314503617348.dkr.ecr.ap-southeast-1.amazonaws.com; sudo docker-compose up -d"'
			}
		}
    }
}
