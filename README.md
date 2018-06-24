# Terraform awspec docker image

This is a special version to build a docker image for terraform [awspec](https://github.com/k1LoW/awspec) testing.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Dockerfile](#dockerfile)
- [Public image](#public-image)
- [build local image](#build-local-image)
- [Installed tools](#installed-tools)
- [Usage](#usage)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Dockerfile

https://github.com/alpine-docker/bundler/blob/terraform-awspec/Dockerfile

# Public image

https://hub.docker.com/r/alpine/bundle-terraform-awspec/tags/

# build local image

    docker buld -t terraform-awspec .

# Installed tools
```
ruby v2.4.2
gem bundler
gem awspec
gem kitchen-terraform
gme kitchen-verifier-awspec
terraform v0.11.7
kubectl
heptio authorizer v0.3.0
```
# Usage

Use repo [terraform-aws-modules/terraform-aws-eks](https://github.com/terraform-aws-modules/terraform-aws-eks.git) as sample.

    # git clone https://github.com/terraform-aws-modules/terraform-aws-eks.git
    $ cd terraform-aws-eks
    # Mount the local folder to /apps in container.
    # Share aws credentials into containers (or by environment variables, such as AWS_ACCESS_KEY_ID, AWS_ACCESS_KEY_ID, and AWS_SESSION_TOKEN
    $ docker run -ti -v $(pwd):/apps -v ~/.aws:/root/.aws alpine/bundle-terraform-awspec:1.0 bash
    $ bundle install
    $ bundle exec kitchen create
    $ bundle exec kitchen converge
    $ bundle exec kitchen setup
    $ bundle exec kitchen verify
    $ bundle exec kitchen destroy

    # Above bundle commands can be combined with one command
    $ bundle exec kitchen test

    # run bundle container as command
    alias bundle="docker run -ti --rm -v $(pwd):/apps alpine/bundle-terraform-awspec:1.0 bundle "
    bundle --help

If you need test with other terraform versions, download specified terraform version from [Linux 64-bit](https://www.terraform.io/downloads.html), give execute permission (`chmod +x <path>/terraform`), run below command:

    docker run -ti -v $(pwd):/apps -v ~/.aws:/root/.aws -v <path>/terraform:/usr/bin/terraform alpine/bundle-terraform-awspec:1.0 bash
