#!/bin/bash

echo "This script removes 'role' from database on the localhost"

if [[ $(whoami) != "root" ]]; then
echo "You must be root to run"
exit 1
fi

if [[ -z "$1" ]]; then
echo "No input id specified!"
exit
fi


sudo -u postgres $(which psql) -U postgres <<SQL
\c unidata
SELECT * FROM public.s_role;

DELETE FROM public.s_role_property_value WHERE role_id = '$1';
DELETE FROM public.s_role WHERE id = '$1';

SELECT * FROM public.s_role;
SQL
