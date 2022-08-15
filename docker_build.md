### Dubuntu with kubectl, AWS and Terraform


### Copy the SSH private key to the path
```sh
cp /Users/eabuhna/.ssh/id_rsa init/
````

### Build the docker image

```sh
docker build -f Dockerfile --force-rm -t aws_abr_dubuntu .
```

### Run the kubectl and aws commands make life bliss

```sh
docker run --hostname aws-abr-dubuntu --rm -it --name eks aws_abr_dubuntu

# For making persistant
docker run -d --hostname aws-abr-dubuntu --rm -it --name aws_abr_dubuntu aws_abr_dubuntu

docker run -e AWS_ACCESS_KEY_ID=xyz -e AWS_SECRET_ACCESS_KEY=aaa myimage
```
