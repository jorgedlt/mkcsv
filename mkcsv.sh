#!/usr/bin/env bash

#
#
#

# Generate Random Pronouceable Words
rpw () {
        cons=(b c d f g h j k l m n p r s t v w x z pt gl gr ch ph ps sh st th wh)
        conscs=(ck cm dr ds ft gh gn kr ks ls lt lr mp mt ms ng ns rd rg rs rt ss ts tch)
        vows=(a e i o u y ee oa oo)

        len=$((($1+0 == 0) ? 6 : $1+0))
        alt=$RANDOM
        word=

        while [ ${#word} -lt $len ]; do
                if [ $(($alt%2)) -eq 0 ]; then
                        rc=${cons[(($RANDOM%${#cons[*]}))]}
                else
                        rc=${vows[(($RANDOM%${#vows[*]}))]}
                fi

                if [ $((${#word}+${#rc})) -gt $len ]; then continue; fi

                word=$word$rc
                ((alt++))

                if [ ${#word} -eq 1 ]; then
                        cons=(${cons[@]} ${conscs[@]})
                fi
        done
        echo $word
}

# Shamelessly Stolen From
# http://planetozh.com/blog/2012/10/generate-random-pronouceable-words/

# echo $BASH_VERSION
#[ "${BASH_VERSINFO:-0}" -ge 4 ] && { echo "bash great than 4.x" ; } || { echo "bash pre version 4.x" ; exit 100 ; }

# echo the header
echo "cognito:username,name,given_name,family_name,middle_name,nickname,preferred_username,\
profile,picture,website,email,email_verified,gender,birthdate,zoneinfo,locale,phone_number,\
phone_number_verified,address,updated_at,cognito:mfa_enabled"

for ((i = 0 ; i < 8 ; i++)); do

    fName="$( rpw 5 )"; fName="${fName^}"   # "${foo^}" - BASH v4+ convention of upprcase 1st char
    lName="$( rpw 8 )"; lName="${lName^}"
    pNumb="$( head -c9 <(echo $RANDOM$RANDOM$RANDOM) )"   # Genrate 9 digit number in BASH

    # Generate Fake Date
    bdMon=$( gshuf -i1-9 -n1)         # add leading 0
    bdDay=$( gshuf -i10-30 -n1)       # fake day 10~30
    bdAno=$( gshuf -i1989-2004 -n1)   # fake year 1989-2004
    #
    sName=$( rpw 10 ); sName="${sName^}"
    sNumb=$(head -c4 <(echo $RANDOM$RANDOM$RANDOM))
    #
    echo -n "${fName},,${fName},${lName},,,,,,,${fName}.${lName}@example.com,TRUE,,"
    echo "0${bdMon}/${bdDay}/${bdAno},,,+12${pNumb},TRUE,${sNumb} ${sName} Street Fake Falls City,,FALSE"
#
done | tr -s ' '
#
