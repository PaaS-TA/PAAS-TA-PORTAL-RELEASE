#!/bin/bash

api_uri="<%= p('cloudfoundry.cc.api.url')%>"
uaa_uri="<%= p('cloudfoundry.cc.api.uaaUrl')%>"
echo "start api host change"
if [[ "$api_uri" =~ "xip.io" ]]; then
  echo "insert/update hosts entry"

  ip_address=${api_uri#"https://api."}
  ip_address=${ip_address#"http://api."}
  ip_address=${ip_address%".xip.io"}
  host_name="api.${ip_address}.xip.io"

  echo "find existing instances in the host file and save the line numbers"
  host_entry="${ip_address} ${host_name}"
  echo $host_entry
  matches_in_host="$(grep -n $host_name /etc/hosts | cut -f1 -d:)"

  echo "line :: $matches_in_host"

  if [ -z $matches_in_host ]; then
    echo "add host entry"
    echo "$host_entry" >> /etc/hosts
  else
    echo "update host entry"
    sed -i  "${matches_in_host}s/.*/$host_entry/g" /etc/hosts
  fi

fi

echo "start uaa host change"
if [[ "$uaa_uri" =~ "xip.io" ]]; then
  echo "insert/update hosts entry"

  ip_address=${uaa_uri#"https://uaa."}
  ip_address=${ip_address#"http://uaa."}
  ip_address=${ip_address%".xip.io"}
  host_name="uaa.${ip_address}.xip.io"

  echo "find existing instances in the host file and save the line numbers"
  host_entry="${ip_address} ${host_name}"
  echo $host_entry
  matches_in_host="$(grep -n $host_name /etc/hosts | cut -f1 -d:)"

  echo "line :: $matches_in_host"

  if [ -z $matches_in_host ]; then
    echo "add host entry"
    echo "$host_entry" >> /etc/hosts
  else
    echo "update host entry"
    sed -i  "${matches_in_host}s/.*/$host_entry/g" /etc/hosts
  fi

fi

echo "start login host change"
if [[ "$api_uri" =~ "xip.io" ]]; then
  echo "insert/update hosts entry"

  ip_address=${api_uri#"https://api."}
  ip_address=${ip_address#"http://api."}
  ip_address=${ip_address%".xip.io"}
  host_name="login.${ip_address}.xip.io"

  echo "find existing instances in the host file and save the line numbers"
  host_entry="${ip_address} ${host_name}"
  echo $host_entry
  matches_in_host="$(grep -n $host_name /etc/hosts | cut -f1 -d:)"

  echo "line :: $matches_in_host"

  if [ -z $matches_in_host ]; then
    echo "add host entry"
    echo "$host_entry" >> /etc/hosts
  else
    echo "update host entry"
    sed -i  "${matches_in_host}s/.*/$host_entry/g" /etc/hosts
  fi

fi

