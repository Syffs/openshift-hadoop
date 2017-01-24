[![Build status](https://travis-ci.org/radanalyticsio/openshift-spark.svg?branch=master)](https://travis-ci.org/radanalyticsio/openshift-spark)
[![Docker build](https://img.shields.io/docker/automated/radanalyticsio/openshift-spark.svg)](https://hub.docker.com/r/radanalyticsio/openshift-spark)

# Apache Spark images for OpenShift

# Init

Edit `SPARK_IMAGE` in Makefile to reflect your private registry

# Build

    make build

# Push

    make push

# Test on Openshift cluster

    oc login <...>
    make create

