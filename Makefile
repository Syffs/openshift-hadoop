# https://github.com/nlnwa/hadoop-openshift
LOCAL_BASE_IMAGE=octest/hadoop

REMOTE_BASE_IMAGE=192.168.1.5:5001/${LOCAL_BASE_IMAGE}

build:
	docker build -t $(LOCAL_BASE_IMAGE) .

clean:
	docker rmi $(LOCAL_BASE_IMAGE)

push: build
	docker tag -f $(LOCAL_BASE_IMAGE) $(REMOTE_BASE_IMAGE)
	docker push $(REMOTE_BASE_IMAGE)

create: push template.yaml
	oc process -f template.yaml > template.active
	oc create -f template.active

destroy: template.active
	oc delete -f template.active
	rm template.active

cleanoc: 
	ssh root@192.168.1.119 "docker rmi $(docker images | grep "octest/hadoop" | awk '{print $3}')"
	ssh root@192.168.1.106 "docker rmi $(docker images | grep "octest/hadoop" | awk '{print $3}')"
