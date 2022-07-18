package main

import (
	"flag"
	"net/http"

	"github.com/k8stech/alertmanager-wechatrobot-webhook/model"
	"github.com/k8stech/alertmanager-wechatrobot-webhook/notifier"

	"github.com/gin-gonic/gin"
)

var (
	h        bool
	RobotKey string
	addr     string
)

func init() {
	flag.BoolVar(&h, "h", false, "help")
	flag.StringVar(&RobotKey, "RobotKey", "", "global wechatrobot webhook, you can overwrite by alert rule with annotations wechatRobot")
	flag.StringVar(&addr, "addr", ":8999", "listen addr")
}

func main() {

	flag.Parse()

	if h {
		flag.Usage()
		return
	}

	router := gin.Default()
	router.POST("/webhook", func(c *gin.Context) {
		var notification model.Notification

		err := c.BindJSON(&notification)

		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		RobotKey := c.DefaultQuery("key", RobotKey)

		err = notifier.Send(notification, RobotKey)

		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})

		}

		c.JSON(http.StatusOK, gin.H{"message": "send to wechatbot successful!"})

	})
	router.Run(addr)
}
