 aws --profile ctrahey cloudformation create-stack --template-body=file://builder-cfn.yaml --stack-name keydb --parameters ParameterKey=KeyPairName,ParameterValue=m1max-oregon
