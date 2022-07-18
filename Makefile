
bin/wechat-webhook:
	GOOS=linux GOARCH=amd64 go build -ldflags "-w" -o bin/wechat-webhook

# make tke version=wechat-webhook
tke: bin/wechat-webhook
	docker build -f Dockerfile -t ccr.ccs.tencentyun.com/ahfuzhang/victoria-metrics-starter:$(version) . \
	    --network=host --platform=linux/amd64 && \
    docker push ccr.ccs.tencentyun.com/ahfuzhang/victoria-metrics-starter:$(version)

	