#!/usr/bin/env sh

function main() {
    /usr/bin/wechat-webhook -RobotKey $1 -addr $2 -grafanaUrl $3 -alertDomain $4 &
    for (( ; ; )); do
       sleep 60
    done
}

main "$1" "$2" "$3" "$4"

nohup /usr/bin/wechat-webhook -RobotKey "77d13fe6-0047-48bc-803d-900892" -addr ":8888" -grafanaUrl "grafana.vnnox.com/d/PwMJtdvnr/k8s-chu-neng-cnanduat" -alertDomain "emscn-prometheus.ampaura.tech" &> emscn.log &
