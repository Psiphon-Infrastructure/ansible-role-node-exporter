#!/bin/bash
IFS=


while getopts ":hf:d:t:" opt; do
  case $opt in
    h) echo help messege;;
    f) STATUS_FILE=$OPTARG;;
    d) METRIC_FILE=$OPTARG;;
    t) INTERVAL=$OPTARG;;
    ?) echo error ;;
  esac
done

while true; do
  sessions=`sed -n '/^Common/,/^ROUTING/{ /Common/d; /ROUTING/d; p}' $STATUS_FILE`
  virtual=`sed -n '/^Virtual/,/^GLOBAL/{ /Virtual/d; /GLOBAL/d; p}' $STATUS_FILE`
  total_clients=0
  echo > $METRIC_FILE
  while IFS= read -r line; do
    IFS=',' read -ra connection <<< "$line"   
    name=${connection[0]}
    ip=${connection[1]}
    bytes_received=${connection[2]}
    bytes_sent=${connection[3]}
    connected_since=${connection[4]}
    virtual_ip=`grep ,$name, <<< $virtual`
    virtual_ip=${virtual_ip%%,*}
    total_clients=$((total_clients+1))

    echo openvpn_server_connected_client \{common_name="$name",real_address="$ip",virtual_address="virtual_ip",connected_since="$connected_since"\} 1 >> $METRIC_FILE
    echo openvpn_server_client_received_bytes \{common_name="$name",real_address="$ip",virtual_address="virtual_ip",connected_since="$connected_since"\} $bytes_received >> $METRIC_FILE
    echo openvpn_server_client_sent_bytes \{common_name="$name",real_address="$ip",virtual_address="virtual_ip",connected_since="$connected_since"\} $bytes_sent >> $METRIC_FILE
  done <<< "$sessions"
  echo openvpn_total_clients $total_clients >> $METRIC_FILE
  sleep $INTERVAL
done
