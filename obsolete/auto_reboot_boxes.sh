#!/bin/bash

#while read line; do if [[ "$line" != \#* ]]; then RACKSCREEN[$i]="$line"; i=$(($i+1)); fi; done < screennames_dvbs.txt
RACKSCREEN_FSP=( 8117.kir01 18339.kir02 )
RACKIP_FSP=( 10.11.5.205 10.11.5.207 )
RACKPOSTFIX_FSP=( sams205 sams207 )
RACKCONF_FSP=( nfs_nfs )
RACKBUILD_FSP=( autobuild-10_7_0_dev-dev )
#RACKBUILD_FSP=( autobuild-10_7_0-dev )
RACKTEST_FSP=(
test_switching_applications_ondemand_eas2.sh
test_switching_applications_ondemand_eas2.sh
)
RACKTEST_FSP2=(
test_switching_applications_ondemand.sh
test_switching_applications_ondemand.sh
)


RACKSCREEN_DVBS=( 2100.kir01 2123.kir02 2146.kir03 2169.kir04 2192.kir05 )
RACKIP_DVBS=( 10.11.4.207 10.11.4.208 10.11.4.209 10.11.4.210 10.11.4.211 )
RACKPOSTFIX_DVBS=( sams207 sams208 sams209 sams210 sams211 )
RACKCONF_DVBS=( nfs_nfs )
#RACKBUILD_DVBS=( autobuild-10_7_0_dev-dev )
RACKBUILD_DVBS=( autobuild-10_7_0-dev )
#RACKBUILD_DVBS=( autobuild-10_7_0_dev-eng-132 )
RACKTEST_DVBS0=(
test_ondemand_300HBOD_320SHOD_340STZOD_350STEOD_390TMCOD_500VOD_502FOD_531POD.sh 
test_switching_applications_ondemand.sh
test_ondemand_change_ch.sh
test_ondemand_change_ch.sh
test_ondemand_main_menu.sh
)
RACKTEST_DVBS2=(
test_timeshift_pause_at_left_border.sh
test_timeshift_pause_at_left_border.sh
test_timeshift_pause_at_left_border.sh
test_timeshift_pause_at_left_border.sh
test_switching_applications_ondemand.sh
)
RACKTEST_DVBS3=(
test_ondemand_change_ch.sh
test_ondemand_change_ch.sh
test_ondemand_change_ch.sh
test_ondemand_change_ch.sh
test_ondemand_change_ch.sh
)
RACKTEST_DVBS4=(
test_channels_up_down.sh
test_channels_up_down.sh
test_channels_up_down.sh
test_channels_up_down.sh
test_channels_up_down.sh
)
RACKTEST_DVBS=(
test_ondemand_main_menu.sh
test_ondemand_main_menu.sh
test_ondemand_main_menu.sh
test_ondemand_main_menu.sh
test_ondemand_main_menu.sh
)



RACKSCREEN_ZODIAC=( 18670.kir01 26061.kir02 17059.kir03 24243.kir04 26044.kir05 )
RACKIP_ZODIAC=( 10.11.6.207 10.11.6.211 10.11.6.213 10.11.6.215 10.11.6.216 )
RACKPOSTFIX_ZODIAC=( sams207 sams211 sams213 sams215 sams216 )
RACKCONF_ZODIAC=( nfs_nfs )
RACKBUILD_ZODIAC=( autobuild-10_7_0_dev-dev )
#RACKBUILD_ZODIAC=( autobuild-10_7_0-dev )
#RACKBUILD_ZODIAC=( autobuild-10_7_0_dev-eng-132 )
RACKTEST_ZODIAC=(
test_switching_applications_ondemand.sh
test_switching_applications_ondemand_eas2.sh
test_switching_applications_ondemand.sh
test_switching_applications_ondemand_eas2.sh
test_switching_applications_ondemand.sh
)
RACKTEST_ZODIAC1=(
test_switching_applications_ondemand.sh
test_switching_applications_ondemand.sh
test_switching_applications_ondemand.sh
test_switching_applications_ondemand.sh
test_switching_applications_ondemand.sh
)
RACKTEST_ZODIAC2=(
test_timeshift_pause_at_left_border.sh 
test_timeshift_pause_at_left_border.sh 
test_timeshift_rew_live.sh
test_timeshift_rew_live.sh
test_timeshift_rew_live.sh
)
RACKTEST_ZODIAC3=(
test_ondemand_main_menu.sh
test_ondemand_main_menu.sh
test_ondemand_main_menu.sh
test_ondemand_main_menu.sh
test_ondemand_main_menu.sh
)


RACKSCREEN_NDS=( 20467.kir01 20481.kir02 20495.kir03 20509.kir04 20523.kir05 20537.kir06 20551.kir07 20565.kir08 32268.kir09 32309.kir10 )
RACKIP_NDS=( 10.11.1.207 10.11.1.208 10.11.1.209 10.11.1.210 10.11.1.211 10.11.1.212 10.11.1.213 10.11.1.214 10.11.1.215 10.11.1.216 )
RACKPOSTFIX_NDS=( sams207 sams208 sams209 sams210 sams211 sams212 sams213 sams214 sams215 sams216 )
RACKCONF_NDS=( nfs_nfs )
#RACKBUILD_NDS=( autobuild-10_7_0-dev )
RACKBUILD_NDS=( autobuild-10_7_0_dev-dev )
RACKTEST_NDS0=(
test_switching_applications_eas2.sh
test_switching_applications_FS.sh
test_switching_applications_guide.sh
test_switching_applications_guide_si_clear.sh
test_switching_applications_list.sh
test_switching_applications_menu.sh
test_switching_applications_ondemand.sh
test_switching_applications_ondemand_eas2.sh
test_switching_applications_QS.sh
test_switching_applications_search.sh
)
RACKTEST_NDS3=(
test_switching_applications_ondemand.sh
test_switching_applications_ondemand.sh
test_switching_applications_ondemand.sh
test_switching_applications_ondemand.sh
test_switching_applications_ondemand_eas2.sh
test_switching_applications_ondemand_eas2.sh
test_switching_applications_ondemand_eas2.sh
test_switching_applications_ondemand_eas2.sh
test_ondemand_main_menu.sh
test_ondemand_main_menu.sh
)

RACKTEST_NDS=(
test_switching_applications.sh
test_switching_applications_eas1.sh
test_switching_applications_eas2.sh
test_switching_applications_FS.sh
test_switching_applications_guide.sh
test_switching_applications_guide_si_clear.sh
test_switching_applications_list.sh
test_switching_applications_menu.sh
test_switching_applications_ondemand.sh
test_switching_applications_ondemand_eas2.sh
)
RACKTEST_ALL=(
test_channels_up_down.sh
test_guide_change_days.sh
test_guide_d.sh
test_guide_l_r_e_c+.sh
test_guide_r_d.sh
test_ondemand_300HBOD_320SHOD_340STZOD_350STEOD_390TMCOD_500VOD_502FOD_531POD.sh
test_ondemand_addtocart.sh
test_ondemand_change_ch.sh
test_ondemand_main_menu.sh
test_ondemand_preview_and_playback.sh

test_ondemand_quick_rating_cart_morelikethis.sh
test_ondemand_recommendations.sh
test_ondemand_removefromcart.sh
test_power_off_on_ondemand.sh
test_power_off_on_search.sh
test_power_off_on_settings.sh
test_press_X_button.sh
test_RSDVR_playback_stop_c+.sh
test_switching_applications.sh
test_switching_applications_eas1.sh

test_switching_applications_eas2.sh
test_switching_applications_FS.sh
test_switching_applications_guide.sh
test_switching_applications_guide_si_clear.sh
test_switching_applications_list.sh
test_switching_applications_menu.sh
test_switching_applications_ondemand.sh
test_switching_applications_ondemand_eas2.sh
test_switching_applications_QS.sh
test_switching_applications_search.sh

test_timeshift_parental_switch_barker.sh
test_timeshift_pause_at_left_border.sh
test_timeshift_pause_at_left_border_on_DPI.sh
test_timeshift_pause_c+.sh
test_timeshift_pause_c+_c-.sh
test_timeshift_play_at_right_border.sh
test_timeshift_power_off_on.sh
test_timeshift_rew_ff.sh
test_timeshift_rew_ff_on_DPI.sh
test_timeshift_rew_ff_pause_play.sh

test_timeshift_rew_ff_slow_motion.sh
test_timeshift_rew_live.sh
test_timeshift_timeshiftbufferdrivestatedbg.sh
test_timeshift_timeshiftenableddbg.sh
test_TSB_sleepmode.sh
)

if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi
# setup default variables
if [ -n "$1" ]; then server="$1"; else server="zodiac"; fi
if [ -n "$2" ]; then use_update_autobuild="$2"; else use_update_autobuild=yes; fi
if [ -n "$3" ]; then use_recreate_logs="$3"; else use_recreate_logs=yes; fi
if [ -n "$4" ]; then use_start_tests="$4"; else use_start_tests=yes; fi


if [ "$server" == "fsp" ]; then
server_ip=$fsp_server; server_port=$fsp_port
for (( i=0; i<${#RACKSCREEN_FSP[@]}; i++ )); do
RACKSCREEN[$i]=${RACKSCREEN_FSP[$i]}; RACKIP[$i]=${RACKIP_FSP[$i]}; RACKPOSTFIX[$i]=${RACKPOSTFIX_FSP[$i]}; RACKCONF[$i]=${RACKCONF_FSP[0]}; RACKBUILD[$i]=${RACKBUILD_FSP[0]}; RACKTEST[$i]=${RACKTEST_FSP[$i]}; done
elif [ "$server" == "dvbs" ]; then
server_ip=$dvbs_server; server_port=$dvbs_port
for (( i=0; i<${#RACKSCREEN_DVBS[@]}; i++ )); do
RACKSCREEN[$i]=${RACKSCREEN_DVBS[$i]}; RACKIP[$i]=${RACKIP_DVBS[$i]}; RACKPOSTFIX[$i]=${RACKPOSTFIX_DVBS[$i]}; RACKCONF[$i]=${RACKCONF_DVBS[0]}; RACKBUILD[$i]=${RACKBUILD_DVBS[0]}; RACKTEST[$i]=${RACKTEST_DVBS[$i]}; done
elif [ "$server" == "zodiac" ]; then
server_ip=$zodiac_server; server_port=$zodiac_port
for (( i=0; i<${#RACKSCREEN_ZODIAC[@]}; i++ )); do
RACKSCREEN[$i]=${RACKSCREEN_ZODIAC[$i]}; RACKIP[$i]=${RACKIP_ZODIAC[$i]}; RACKPOSTFIX[$i]=${RACKPOSTFIX_ZODIAC[$i]}; RACKCONF[$i]=${RACKCONF_ZODIAC[0]}; RACKBUILD[$i]=${RACKBUILD_ZODIAC[0]}; RACKTEST[$i]=${RACKTEST_ZODIAC[$i]}; done
elif [ "$server" == "nds" ]; then
server_ip=$nds_server; server_port=$nds_port
for (( i=0; i<${#RACKSCREEN_NDS[@]}; i++ )); do
RACKSCREEN[$i]=${RACKSCREEN_NDS[$i]}; RACKIP[$i]=${RACKIP_NDS[$i]}; RACKPOSTFIX[$i]=${RACKPOSTFIX_NDS[$i]}; RACKCONF[$i]=${RACKCONF_NDS[0]}; RACKBUILD[$i]=${RACKBUILD_NDS[0]}; RACKTEST[$i]=${RACKTEST_NDS[$i]}; done
fi

echo "================== ================== ================== ================== ================== "
echo "0 : server=$server, server_ip:server_port=$server_ip:$server_port"
echo "1 : \$1: use_update_autobuild=$use_update_autobuild"
echo "2 : \$2: use_recreate_logs=$use_recreate_logs"
echo "3 : \$3: use_start_tests=$use_start_tests"
echo
#echo "build=$build"
for (( i=0; i<${#RACKSCREEN[@]}; i++ )); do echo "$server: screen=${RACKSCREEN[$i]} -> ${RACKIP[$i]} -> ${RACKPOSTFIX[$i]} -> ${RACKBUILD[$i]} -> ${RACKCONF[$i]} -> ${RACKTEST[$i]}"; done
echo "sleep 5"
echo "================== ================== ================== ================== ================== "
sleep 5
date

# update_autobuild.sh
echo -e "\n1 of 8. use_update_autobuild=$use_update_autobuild"
if [ "$use_update_autobuild" == "yes" ]; then
#if [ "$build" == "autobuild-10_6_1_dev-dev" ]; then ssh $user@$server_ip -p $server_port "./update_autobuild.sh 1061d"
#elif [ "$build" == "autobuild-10_6_1-dev" ]; then ssh $user@$server_ip -p $server_port "./update_autobuild.sh 1061s"
#elif [ "$build" == "autobuild-10_7_0_dev-dev" ]; then ssh $user@$server_ip -p $server_port "./update_autobuild.sh 107d"
#elif [ "$build" == "autobuild-10_7_0-dev" ]; then ssh $user@$server_ip -p $server_port "./update_autobuild.sh 107s"
#fi
if [ "${RACKBUILD[0]}" == "autobuild-10_7_0_dev-dev" ]; then ssh $user@$server_ip -p $server_port "./update_autobuild.sh 107d"
elif [ "${RACKBUILD[0]}" == "autobuild-10_7_0-dev" ]; then ssh $user@$server_ip -p $server_port "./update_autobuild.sh 107s"
elif [ "${RACKBUILD[0]}" == "autobuilid-10_6_1_dev-dev" ]; then ssh $user@$server_ip -p $server_port "./update_autobuild.sh 1061d"
elif [ "${RACKBUILD[0]}" == "autobuild-10_6_1-dev" ]; then ssh $user@$server_ip -p $server_port "./update_autobuild.sh 1061s"
else echo "update_autobuild if failed, build=${RACKBUILD[0]} is not specified..."
fi

fi

echo "sleep 2"
sleep 2

date
# reboot boxes: send rebootnow command
echo -e "\n2 of 8. reboot boxes..."
echo "2.1. stop (ctrl+c) running tests(p2)"
echo "2.2. start telnet and reboot if was box flashing(p0)"
echo "2.3. send rebootnow command if wasn't box flashing(p0)"
i=0
for screenname in ${RACKSCREEN[@]}; do
echo "$server: screen=$screenname -> ${RACKIP[$i]}..."
ssh $user@$server_ip -p $server_port " \
screen -d $screenname; \
screen -S $screenname -p1 -X eval 'stuff ^C'; \
screen -S $screenname -p1 -X eval 'stuff ^C'; \
screen -S $screenname -p0 -X eval 'stuff \015'; \
sleep 1; \
screen -S $screenname -p0 -X eval 'stuff \"telnet ${RACKIP[$i]}\"'; \
sleep 1; \
screen -S $screenname -p0 -X eval 'stuff \015'; \
sleep 1; \
screen -S $screenname -p0 -X eval 'stuff root'; \
sleep 1; \
screen -S $screenname -p0 -X eval 'stuff \015'; \
sleep 1; \
screen -S $screenname -p0 -X eval 'stuff reboot'; \
sleep 1; \
screen -S $screenname -p0 -X eval 'stuff \015'; \
sleep 1; \
screen -S $screenname -p0 -X eval 'stuff rebootnow'; \
sleep 1; \
screen -S $screenname -p0 -X eval 'stuff \015'"
i=$(($i+1))
done
date

# sleep 40
echo -ne "\n3 of 8. sleep 40sec for reboot box kernel..."
for (( i=1; i<=40; i++ )); do
sleep 1
echo -n "$i "
done


# reset terminal after reboot boxes
echo -e "\n\n4 of 8. reset (ctrl+c) terminal after reboot boxes(p0)..."
i=0
for screenname in ${RACKSCREEN[@]}; do
echo "$server: screen=$screenname -> ${RACKIP[$i]}..."
ssh $user@$server_ip -p $server_port " \
screen -S $screenname -p0 -X eval 'stuff ^C'; \
sleep 1; \
screen -S $screenname -p0 -X eval 'stuff ^C'; \
sleep 1"
i=$(($i+1))
done


#####################################################
# use_recreate_logs
echo -e "\n5 of 8. use_recreate_logs=$use_recreate_logs"
if [ "$use_recreate_logs" == "yes" ]; then
# close logs, start logs, reattach to logs
echo "5.1. close logs(p0) - exit(ctrl+d) from script app"
echo "5.2. start logs(p0) - start script app"
echo "5.3. reattach logs(p1)"
i=0
for screenname in ${RACKSCREEN[@]}; do
echo "$server: screen=$screenname p0 -> ${RACKIP[$i]}..."
ssh $user@$server_ip -p $server_port " \
screen -S $screenname -p0 -X eval 'stuff ^D'; \
sleep 7; \
screen -S $screenname -p0 -X eval 'stuff \"./script.sh ${RACKPOSTFIX[$i]}\"'; \
sleep 1; \
screen -S $screenname -p0 -X eval 'stuff \015'; \
sleep 1"
i=$(($i+1))
done
fi
#use_recreate_logs                                   
#####################################################


# stop tail_logs.sh and start again
echo -e "\n6 of 8. stop tail_logs.sh and start again (if new patterns.ini)..."
echo "skipped"
#i=0
#for screenname in ${RACKSCREEN[@]}; do
#echo "$server: screen=$screenname p1 -> ${RACKIP[$i]}..."
#ssh $user@$server_ip -p $server_port " \
#screen -S $screenname -p2 -X eval 'stuff ^C'; \
#sleep 1; \
#screen -S $screenname -p2 -X eval 'stuff ^C'; \
#sleep 1; \
#screen -S $screenname -p2 -X eval 'stuff \"./tail_logs.sh ${RACKPOSTFIX[$i]}\"'; \
#sleep 1; \
#screen -S $screenname -p2 -X eval 'stuff \015'; \
#sleep 1"
#i=$(($i+1))
#done


# start telnet, send root to telnet, start build
echo -e "\n7 of 8. start builds:"
echo "7.1. start telnet(p0)"
echo "7.2. send root to telnet(p0)"
echo "7.3. start build(p0)"
i=0
for screenname in ${RACKSCREEN[@]}; do
echo "$server: screen=$screenname p0 -> ${RACKIP[$i]} -> ${RACKBUILD[$i]} -> ${RACKCONF[$i]}"
ssh $user@$server_ip -p $server_port " \
screen -S $screenname -p0 -X eval 'stuff \"telnet ${RACKIP[$i]}\"'; \
sleep 1; \
screen -S $screenname -p0 -X eval 'stuff \015'; \
sleep 1; \
screen -S $screenname -p0 -X eval 'stuff root'; \
sleep 1; \
screen -S $screenname -p0 -X eval 'stuff \015'; \
sleep 1; \
screen -S $screenname -p0 -X eval 'stuff \"cd /mnt/nfs/bin/kgrushin/${RACKBUILD[$i]}/usr/bin/&&./run.sh ${RACKCONF[$i]}\"'; \
sleep 1; \
screen -S $screenname -p0 -X eval 'stuff \015'; \
sleep 1"
i=$(($i+1))
done


# start tests
echo -e "\n8 of 8. use_start_tests=$use_start_tests"
if [ "$use_start_tests" == "yes" ]; then
echo "8.1 start test(p2)"
i=0
for screenname in ${RACKSCREEN[@]}; do
echo "$server: screen=$screenname -> ${RACKIP[$i]} -> ${RACKTEST[$i]}"
ssh $user@$server_ip -p $server_port " \
screen -S $screenname -p1 -X eval 'stuff \"./${RACKTEST[$i]} ${RACKIP[$i]}\"'; \
sleep 1; \
screen -S $screenname -p1 -X eval 'stuff \015'; \
sleep 1"
i=$(($i+1))
done
fi
date
echo "====== ====== THE END ====== ======"
echo
