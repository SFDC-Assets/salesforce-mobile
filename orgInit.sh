#sfdx shane:org:create -f config/project-scratch-def.json -d 30 -s --wait 60 --userprefix admin -o mobile.demo
sfdx force:org:create -f config/project-scratch-def.json -a salesforce-mobile -s -d 30 -w 60
sfdx force:source:push
sfdx force:user:permset:assign -n SalesforceMobile
sfdx shane:user:password:set -g User -l User -p salesforce1
#sfdx automig:dump --objects Task --outputdir ./data
sfdx automig:load --inputdir ./data
sfdx force:org:open
