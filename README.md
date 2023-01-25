# AWS Notes
Getting started with aws 

Install AWSCLI- https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

Download the file(downloads to current directory)
```
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
```
Run macOS installer program, specifying the package and target(which drive to install the package to). The files are installed to /usr/local/aws-cli, and a symlink is automatically created in /usr/local/bin
```
sudo installer -pkg AWSCLIV2.pkg -target /
```

To verify install:
```
$which aws
/usr/local/bin/aws 

$aws --version
aws-cli/2.9.17 Python/3.9.11 Darwin/21.4.0 exe/x86_64 prompt/off
```

⇒ First: Create secret key in AWS console (in IAM), then, in your command line:
```
$ aws configure
```
AWS Access Key ID [None]: *********
AWS Secret Access Key [None]: *********
Default region name [None]: us-east-1
Default output format [None]: json

$aws configure creates two new files in ~/.aws/config & ~/.aws/credentials 

Verify using these command,
```
$ cat ~/.aws/config
$ cat ~/.aws/credentials 
```

Edit these files to change the config or add a second profile etc. 

—-

#For EC2:

EC2 - Instances via GUI 
-Name
-Select image 
-t2.micro
-Generate key pair - download key pair - secure keyPair:
```
$chmod 400 keypair.pem 
```
-Security policy as desired 
-Launch Instance 

Once instance is launched and keyPair.pem file permissions are secured -> 
right click on the instance and click connect -> select SSH client for instructions 

In command line/ssh-terminal:
```
ssh -i “path/to/privatekeyfile.pem” ec2-user@<copy public IPv4 DNS here>
```


Starting a simple CRA on the linux image:

https://docs.aws.amazon.com/sdk-for-javascript/v2/developer-guide/setting-up-node-on-ec2-instance.html

(Amazon Linux 2 image does not support the LTS release of node.js. So, use nvm install 16) 

The node installation only applies to the current Amazon EC2 session. If you restart your CLI session you need to use nvm to enable the installed node version. If the instance is terminated, you need to install node again. The alternative is to make an Amazon Machine Image (AMI) of the Amazon EC2 instance once you have the configuration that you want to keep.
