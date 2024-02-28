# How to install K8s 1.29


## Please note: 
  - A key pair will need to be administrated as a template reference for  ssh authentication to deployed EC2s, in this case, titled 'node-key'
  - The pair must be deployed the same region that your instances are hosted


## Instructions: 
  1) Run the Terraform from the root Terraform directory
  2) Use ssh via your administrated keys to access your instance shells
  3) Run the install-k8s.sh script from the root directory of each machine or as described 
