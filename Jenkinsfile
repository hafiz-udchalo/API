pipeline {
  options {
      buildDiscarder(logRotator(numToKeepStr: '3'))
  }
  agent any
  environment {
     NODE_ENV = 'prod'
     BUCKET = 'api-gateway-$NODE_ENV'  
  }
  stages {
    stage('Checkout SCM') {
      steps {
        script {
          
          // calculate GIT lastest commit short-hash
          gitCommitHash = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
          shortCommitHash = gitCommitHash.take(7)
          // calculate a sample version tag
          VERSION = shortCommitHash
          // set the build display name
          currentBuild.displayName = "#${BUILD_ID}-${VERSION}"
          echo 'git_branch:' + env.GIT_BRANCH
 
        }
      }
    }

    stage('Deploy Step') {
	  steps {
	    script {
	       sh "aws s3 mb s3://$BUCKET"
	       sh "chmod +x -R ${env.WORKSPACE}/build.sh"
	       sh "./build.sh $NODE_ENV"
		}
	  }
    }
  }
}
