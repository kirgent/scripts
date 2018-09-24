#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

target_lib="Reminders/lib"

#for file in ls "/opt/idea-community-2017.2.2/plugins/junit/lib/"; do
#upload_to.sh $file kirill.grushin@10.12.1.100 $target_lib/ no
#done

#for file in ls "/home/kirill.grushin/.m2/repository/org/junit/*"; do
#upload_to.sh $file kirill.grushin@10.12.1.100 $target_lib/ no
#done

for file in ls -1R "/home/kirill.grushin/.m2/repository/org/junit/*"; do
upload_to.sh $file kirill.grushin@10.12.1.100 $target_lib/ no
done
