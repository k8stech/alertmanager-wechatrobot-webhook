
bin/wechat-webhook:
	go build -o bin/wechat-webhook

# make tke version=wechat-webhook
tke: bin/wechat-webhook
	docker build -f Dockerfile -t ccr.ccs.tencentyun.com/ahfuzhang/victoria-metrics-starter:$(version) . \
	    --network=host --platform=linux/amd64 && \
    docker push ccr.ccs.tencentyun.com/ahfuzhang/victoria-metrics-starter:$(version)

	