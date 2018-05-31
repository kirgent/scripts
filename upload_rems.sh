#!/bin/bash
#dir="scripts/tests"
dir="IdeaProjects/Reminders/src/main/bash/"

upload_to.sh $dir/test_reminder.sh kirill.grushin@10.12.1.100 . no
upload_to.sh $dir/test_reminder_add.sh kirill.grushin@10.12.1.100 . no
upload_to.sh $dir/test_reminder_modify.sh kirill.grushin@10.12.1.100 . no
upload_to.sh $dir/test_reminder_delete.sh kirill.grushin@10.12.1.100 . no

upload_to.sh $dir/test_reminder_oldapi.sh kirill.grushin@10.12.1.100 . no
upload_to.sh $dir/test_reminder48.sh kirill.grushin@10.12.1.100 . no
upload_to.sh $dir/test_reminder288.sh kirill.grushin@10.12.1.100 . no
upload_to.sh $dir/test_reminder720.sh kirill.grushin@10.12.1.100 . no

exit
upload_to.sh $dir/test_reminder.sh kirill.grushin@10.12.1.99 . no
upload_to.sh $dir/test_reminder2.sh kirill.grushin@10.12.1.99 . no
upload_to.sh $dir/test_reminder_add.sh kirill.grushin@10.12.1.99 . no
upload_to.sh $dir/test_reminder_modify.sh kirill.grushin@10.12.1.99 . no
upload_to.sh $dir/test_reminder_delete.sh kirill.grushin@10.12.1.99 . no
