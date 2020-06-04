pipeline {
  options {
      buildDiscarder(logRotator(numToKeepStr: '3'))
  }
  agent any
  environment {
    NODE_ENV = 'dev'
  }
  stages {
    stage('Build preparations') {
      steps {
        script {
          // calculate GIT lastest commit short-hash
          gitCommitHash = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
          shortCommitHash = gitCommitHash.take(7)
          if(env.GIT_BRANCH == "master"){
            NODE_ENV = 'prod'
          } else 
          if(env.GIT_BRANCH == "stage"){
            NODE_ENV = 'stage'
          } else
          if(env.GIT_BRANCH == "uat"){
            NODE_ENV = 'uat'
          } else {
            NODE_ENV = 'dev'
          }
          // calculate a sample version tag
          VERSION = "$NODE_ENV-$shortCommitHash"
          // set the build display name
          currentBuild.displayName = "#${BUILD_ID}-${VERSION}"
		  echo 'git_branch:' + env.GIT_BRANCH
	     BUCKET="deploy-api-$NODE_ENV"
	     STACK="Test-API-Gateway-$NODE_ENV"
        }
      }
    }
    stage('API Build and Deploy') {
      steps {
        script {
          sh "chmod +x -R ${env.WORKSPACE}/build.sh"
	  sh "./build.sh $NODE_ENV"
	  sh "sam package --template-file template.yaml --s3-bucket $BUCKET --output-template-file package.yaml"
	  sh "sam deploy --template-file package.yaml --stack-name $STACK --capabilities CAPABILITY_IAM"
        }
      }
    }
  }
}
