# Apache Hadoop images for OpenShift

# Init

Edit `SPARK_IMAGE` in Makefile to reflect your private registry

# Build

    make build

# Push

    make push

# Test on Openshift cluster

    oc login <...>
    make create

