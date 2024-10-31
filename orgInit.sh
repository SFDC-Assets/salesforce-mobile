sf demoutil org create scratch -f config/project-scratch-def.json -d 5 -s -p admin -e mobile.demo
sf project deploy start
sf org assign permset -n SalesforceMobile
sf demoutil user password set -p salesforce1 -g User -l User
sf automig load --inputdir ./data
sf org open
