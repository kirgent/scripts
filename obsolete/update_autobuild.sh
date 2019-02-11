#/bin/bash
nfsdir="/nfsroot_samsung/bin"
workdir="$nfsdir/kgrushin"
d1061="autobuild-10_6_1_dev-dev"
s1061="autobuild-10_6_1-dev"
d107="autobuild-10_7_0_dev-dev"
s107="autobuild-10_7_0-dev"
#eng="autobuild-10_7_0-eng"

if [ -n "$1" ]; then
if [ "$1" == "1061d" ]; then build="$d1061"
elif [ "$1" == "1061s" ]; then build="$s1061"
elif [ "$1" == "107d" ]; then build="$d107"
elif [ "$1" == "107s" ]; then build="$s107"
#elif [ "$1" == "eng"]; then build="$eng"
else build="$d107"
fi
else build="$d107" 
fi

echo
echo "=========================================================="
echo "1061d: `ls -ld $nfsdir/$d1061`: `cat $nfsdir/$d1061/home/zodiac/version.txt`"
echo "1061s: `ls -ld $nfsdir/$s1061`: `cat $nfsdir/$s1061/home/zodiac/version.txt`"
echo "107d: `ls -ld $nfsdir/$d107`: `cat $nfsdir/$d107/home/zodiac/version.txt`"
echo "107s: `ls -ld $nfsdir/$s107`: `cat $nfsdir/$s107/home/zodiac/version.txt`"
echo "=========================================================="

supervisor_yaml="$workdir/$build/home/zodiac/supervisor_oob_dal.yaml"
dvbs_yaml="$workdir/$build/home/zodiac/dvbs.yaml"
profile_ini="$workdir/$build/home/zodiac/profile.ini"
profile_li_ini="$workdir/$build/home/zodiac/profile_li.ini"
startup_cfg="$workdir/$build/home/zodiac/startup.cfg"
echo "nfsdir=$nfsdir"
echo "workdir=$workdir"
echo "\$1=$1"
echo "build=$build"
echo "update from build -> to build:"
#echo "`cat $workdir/$build/home/zodiac/version.txt` -> `cat $nfsdir/$build/home/zodiac/version.txt`"
echo "`cat $workdir/$build/home/zodiac/version.txt|cut -d "_" -f 3|cut -c 4-` -> `cat $nfsdir/$build/home/zodiac/version.txt|cut -d "_" -f 3|cut -c 4-`"

echo "sleep 5 seconds..."
sleep 5
#read -p "Continue? " -n 1 -r
#echo
#if [[ ! $REPLY =~ ^[Yy]$ ]]; then exit 1; fi

#echo "removing $workdir/$build'__prev' ..."
#rm -rf $workdir/$build'__prev'

#echo "moving $workdir/$build $workdir/$build'__prev' ..."
#mv -v $workdir/$build $workdir/$build'__prev'
echo "removing old $workdir/$build ..."
rm -rf $workdir/$build

echo "copying new $nfsdir/$build to $workdir/ ..."
cp -r $nfsdir/$build $workdir/

#chmod o+w $profile_ini $supervisor_yaml $dvbs_yaml
echo

############################################## ##############################################
############################################## supervisor_yaml
############################################## ##############################################
#echo "changes in file supervisor_yaml :"
#grep --color=always -H "stbman" $supervisor_yaml

#if [ -n "`grep ncas_host_app $supervisor_yaml`" ]; then
#sed -i '/- ncas_host_app/s/^/#/' $supervisor_yaml
#sed -i '/- .\/ncas_host_app/s/^/#/' $supervisor_yaml
#grep --color=always -H -E "\- ncas_host_app|\- \.\/ncas_host_app" $supervisor_yaml
#fi

#if [ -n "`grep sdvd $supervisor_yaml`" ]; then
#sed -i '/- sdvd/s/^/#/' $supervisor_yaml
#sed -i '/- .\/sdvd/s/^/#/' $supervisor_yaml
#grep --color=always -H -E "\- sdvd|\- \.\/sdvd" $supervisor_yaml
#fi

#if [ -n "`grep dpi_host_app $supervisor_yaml`" ]; then
#sed -i '/- dpi_host_app/s/^/#/' $supervisor_yaml
#sed -i '/- .\/dpi_host_app/s/^/#/' $supervisor_yaml
#grep --color=always -H -E "\- dpi_host_app|\- \.\/dpi_host_app" $supervisor_yaml
#fi

#if [ -n "`grep history $supervisor_yaml`" ]; then
#sed -i '/- history/s/^/#/' $supervisor_yaml
#sed -i '/- \/mnt\/flash\/zodiac\/build\/usr\/bin\/history/s/^/#/' $supervisor_yaml
#grep --color=always -H -E "\-.*history|\- history" $supervisor_yaml
#fi

#if [ -n "`grep wait_for_dcd $supervisor_yaml`" ]; then sed -i 's/wait_for_dcd.*/wait_for_dcd: false/' $supervisor_yaml; fi
#grep --color=always -H "wait_for_dcd" $supervisor_yaml

#if [ -n "`grep wait_for_ip $supervisor_yaml`" ]; then sed -i 's/wait_for_ip.*/wait_for_ip: false/' $supervisor_yaml; fi
#grep --color=always -H "wait_for_ip" $supervisor_yaml

#if [ "$put_supervisor" == "y" ]; then
#sed -i '/- file:\/\/\//s/^/#/' $supervisor_yaml
#sed -i '/- oc:\/\//s/^/#/' $supervisor_yaml
#sed -i '/- http:\/\//s/^/#/' $supervisor_yaml
#sed -i '/^#        - http:\/\/cdsuifs/a\ \ \ \ \ \ \ \ - http:\/\/10\.251\.208\.118\/DAL2\/'$dgroup'\/supervisor\.cfg' $supervisor_yaml
##http:\/\/10.251.208.118\/DAL2\/$dgroup\/supervisor\.cfg
#fi
#grep --color=always -H -E "\- file:///|\- oc://|\- http://" $supervisor_yaml
#echo

############################################## ##############################################
############################################## dvbs_yaml
############################################## ##############################################
#echo "changes in file dvbs_yaml :"
#sed -i 's/    probe_type.*/    probe_type: block-device/' $dvbs_yaml
#grep --color=always -H -i -A 8 "Timeshift" $dvbs_yaml
#echo

############################################## ##############################################
############################################## profile_ini & profile_li_ini
############################################## ##############################################
echo "changes in files profile_ini and profile_li_ini :"
#echo "changed :"
#sed -i '/ads.assetcontrol.config.oob/s/^/#/' $profile_ini
#sed -i '/ads.assetcontrol.content.oob/s/^/#/' $profile_ini
grep --color=always -H -i -E "ads\.assetcontrol\.config\.oob|ads\.assetcontrol\.content\.oob" $profile_ini
#echo ": changed"


#if [ -z "`grep stand_by_after_boot $profile_ini`" ]; then echo "stand_by_after_boot=0" >> $profile_ini; else sed -i 's/stand_by_after_boot.*/stand_by_after_boot=0/' $profile_ini; fi
#grep --color=always -H -E "stand_by_after_boot" $profile_ini
#if [ -z "`grep stand_by_after_boot $profile_li_ini`" ]; then echo "stand_by_after_boot=0" >> $profile_li_ini; else sed -i 's/stand_by_after_boot.*/stand_by_after_boot=0/' $profile_li_ini; fi
#grep --color=always -H -E "stand_by_after_boot" $profile_li_ini


#sed -i 's/IpgDataPath.*/IpgDataPath = http:\/\/10\.251\.229\.93:5051\/encoder\/encoder_output\/oms\/10\.251\.226\.76\//' $profile_ini
#sed -i 's/IpgDataFirstPath.*/IpgDataFirstPath = http:\/\/10\.251\.229\.93:5051\/encoder\/encoder_output\/oms\/10\.251\.226\.76\//' $profile_ini
grep --color=always -H -i -E "IpgDataPath|IpgDataFirstPath" $profile_ini
grep --color=always -H -i "ui_build" $profile_ini


echo "added :"
if [ -z "`grep RSDVREnabledDbg $profile_ini`" ]; then echo "RSDVREnabledDbg=1" >> $profile_ini; else sed -i 's/RSDVREnabledDbg.*/RSDVREnabledDbg=1/' $profile_ini; fi
if [ -z "`grep RSDVREnabledDbg $profile_li_ini`" ]; then echo "RSDVREnabledDbg=1" >> $profile_li_ini; else sed -i 's/RSDVREnabledDbg.*/RSDVREnabledDbg=1/' $profile_li_ini; fi
if [ -z "`grep TimeShiftEnabledDbg $profile_ini`" ]; then echo "TimeShiftEnabledDbg=1" >> $profile_ini; else sed -i 's/TimeShiftEnabledDbg.*/TimeShiftEnabledDbg=1/' $profile_ini; fi
if [ -z "`grep TimeShiftEnabledDbg $profile_li_ini`" ]; then echo "TimeShiftEnabledDbg=1" >> $profile_li_ini; else sed -i 's/TimeShiftEnabledDbg.*/TimeShiftEnabledDbg=1/' $profile_li_ini; fi
grep --color=always -H -i -E "RSDVREnabled|RSDVREnabledDbg|TimeShiftEnabled|TimeShiftEnabledDbg" $profile_ini $profile_li_ini
echo ": added"


echo "added :"
if [ -z "`grep -i skip_provisioning_check_flag $profile_ini`" ]; then echo "skip_provisioning_check_flag=1" >> $profile_ini; else sed -i 's/skip_provisioning_check_flag.*/skip_provisioning_check_flag=1/' $profile_ini; fi
if [ -z "`grep -i skip_provisioning_check_flag $profile_li_ini`" ]; then echo "skip_provisioning_check_flag=1" >> $profile_li_ini; else sed -i 's/skip_provisioning_check_flag.*/skip_provisioning_check_flag=1/' $profile_li_ini; fi
if [ -z "`grep -i skip_brick_mode $profile_ini`" ]; then echo "skip_brick_mode=1" >> $profile_ini; else sed -i 's/skip_brick_mode.*/skip_brick_mode=1/' $profile_ini; fi
if [ -z "`grep -i skip_brick_mode $profile_li_ini`" ]; then echo "skip_brick_mode=1" >> $profile_li_ini; else sed -i 's/skip_brick_mode.*/skip_brick_mode=1/' $profile_li_ini; fi
grep --color=always -H -i -E "skip_provisioning_check_flag|skip_brick_mode" $profile_ini $profile_li_ini
echo ": added"


#echo "hubid=27" >> $profile_ini
#echo "hubid=27" >> $profile_li_ini
grep --color=always -H -i "hubid" $profile_ini $profile_li_ini

echo

############################################## ##############################################
############################################## uc.ini
############################################## ##############################################
#echo "changes in file uc.ini :"
#sed -i 's|UploadService.*|UploadService = 10.251.208.118:80/ucPost/stmain.php|' $workdir/$build/ADS/uc.ini
#echo

############################################## ##############################################
############################################## startup_cfg
############################################## ##############################################
#echo "changes in file startup_cfg :"
#if [ -z "`grep stand_by_after_boot $startup_cfg`" ]; then echo "stand_by_after_boot=0" >> $startup_cfg; else sed -i 's/stand_by_after_boot.*/stand_by_after_boot=0/' $startup_cfg; fi
#grep --color=always -H -E "stand_by_after_boot" $startup_cfg
############################################## ##############################################

#micro=`grep micro $workdir/$build/home/zodiac/version.yaml|cut -c 12-`
#mv -v $workdir/$build $workdir/$build'__'$micro'_p'
