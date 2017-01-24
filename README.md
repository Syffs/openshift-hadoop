# Apache Hadoop images for OpenShift

# Init


Edit `REMOTE_BASE_IMAGE` in Makefile to reflect your private registry

I haven't found how to hack around the need of a privileged container, until then an option is to allow privileged container to all users 

    oadm policy add-scc-to-group anyuid system:authenticated

# Build

    make build

# Push

    make push

# Test on Openshift cluster

    oc login <...>
    make create

