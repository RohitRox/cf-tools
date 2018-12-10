# install the required packages
echo "cloning granitic"
git clone -b dev-1.3.0 --single-branch https://github.com/graniticio/granitic $GOPATH/src/github.com/graniticio/granitic
echo "fetching granitic"
go install github.com/graniticio/granitic
echo "fetching service-core"
git clone https://$GIT_USER:$GIT_OUTH_TOKEN@github.com/cloudfactory/service-core $GOPATH/src/github.com/cloudfactory/service-core

echo "fetching granitic yaml"
go get github.com/graniticio/granitic-yaml
echo "installing granitic grnc-yaml-bind"
go install github.com/graniticio/granitic-yaml/cmd/grnc-yaml-bind
echo "installing granitic grnc-ctl"
go install github.com/graniticio/granitic/cmd/grnc-ctl

echo "fetching aws"
go get github.com/aws/aws-sdk-go/aws
echo "fetching satori"
go get github.com/satori/go.uuid
echo "installing jwt"
go get github.com/gbrlsnchs/jwt
