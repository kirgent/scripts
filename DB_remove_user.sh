#!/bin/bash

echo "This script removes 'user' from database on the localhost"

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
SELECT id,login,email,first_name,last_name,created_at,created_by,active,email_notification FROM public.s_user;
DELETE FROM public.s_password WHERE s_user_id = (SELECT id FROM public.s_user WHERE login = '$1');
DELETE FROM public.s_user_property_value WHERE user_id = (SELECT id FROM public.s_user WHERE login = '$1');
DELETE FROM public.s_user WHERE login = '$1';
SELECT id,login,email,first_name,last_name,created_at,created_by,active,email_notification FROM public.s_user;
SQL
