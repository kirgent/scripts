#!/bin/bash

echo "This script reset password to 1q2w3e4r on localhost"

if [[ $(whoami) != "root" ]]; then
echo "You must be root to run"
exit 1
fi

if [[ -z "$1" ]]; then
echo "No input login specified!"
exit
fi

sudo -u postgres $(which psql) -U postgres <<SQL
\c unidata
UPDATE public.s_password SET password_text = '$2a$10$S2owoJJrMr2TxzthaxtFVelPDyZGNuFE0xNkji8KJkdhtJ4CvUnR2' WHERE s_user_id = (SELECT id FROM public.s_user WHERE login = '$1');
SQL
