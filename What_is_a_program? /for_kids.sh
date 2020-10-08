#!/bin/bash
pingu () {
echo '  ----------------------------'
echo '   \'
echo '     \'
echo '         .--.'
echo '        |o_o |'
echo '        |:_/ | '
echo '       //   \ \ '
echo "      (|     | ) "
echo "     /'\_   _/'\ "
echo "     \___)=(___/ "
}

castello () {
echo "               |"
echo "              /^\ "
echo "             /   \ "
echo " _   _   _  /     \  _   _   _ "
echo "[ ]_[ ]_[ ]/ _   _ \[ ]_[ ]_[ ]"
echo "|_=__-_ =_|_[ ]_[ ]_|_=-___-__|"
echo " | _- =  | =_ = _    |= _=   |"
echo " |= -[]  |- = _ =    |_-=_[] |"
echo " | =_    |= - ___    | =_ =  |"
echo " |=  []- |-  /| |\   |=_ =[] |"
echo " |- =_   | =| | | |  |- = -  |"
echo " |_______|__|_|_|_|__|_______|"

}
clear
castello
echo '  Pingu sta dormendo'
read num

clear
echo '  ???'
pingu
sleep 1
xeyes -geometry -1000+500   &
clear
clear
echo "  Che c'e' Stefano?"
pingu
sleep 3
pkill xeyes
clear
clear
echo "  Ah, non siamo soli!"
echo "  Ciao Ragazzi!! ma quanti siete??"
pingu
read num

clear
echo '  E come vi chiamate?'
pingu

sleep 2
clear
echo '  E come vi chiamate?'
echo '  Piano! uno alla volta!'
pingu

for i in $(seq 1 $num)
    do
        read Nome
        clear
        echo ' Piacere di conoscerti' $Nome '!'
        pingu

        if [ $i == 1 ]
            then
                Nomi=$(echo $Nome)
            else
                Nomi=$(echo $Nomi', '$Nome)
        fi
    done
sleep 1
clear
echo '  Ok, Vediamo se mi ricordo tutti i vostri nomi'
pingu
sleep 1
clear

echo '  siete:' $Nomi'. Giusto? (si/no)'
pingu
read giusto

if [ $giusto == 'no' ]
    then
        clear
        echo '  Mi ridite i vostri nomi?'
        pingu
        for i in $(seq 1 $num)
            do
                read Nome
                clear
                echo '  '$Nome', OK'
                pingu
                if [ $i==1 ]
                    then
                        Nomi=$(echo $Nome)
                    else
                        Nomi=$(echo $Nomi', '$Nome)
                fi
            done
    sleep 1
    clear
    echo '  quindi:' $Nomi
    pingu
fi
sleep 1

clear
echo '  Vi va di vedere un treno? (si/no)'
pingu

read risposta

if [ $risposta == 'si' ]
    then
    sl
    clear

    echo '  Volete vedere anche un aquario? (si/no)'
    pingu
    read risposta
    if [ $risposta == 'si' ]
        then
            clear
            echo '  Ricordatevi che per uscire dovete premere ctr-c'
            pingu
            sleep 1
            asciiquarium
    fi
    clear
else
    clear

    echo '  Preferite un aquario? (si/no)'
    pingu

    read risposta
    if [ $risposta == 'si' ]
        then
        clear

        echo '  Ricordatevi che per uscire dovete premere ctr-c'
        pingu
        sleep 1
        asciiquarium
        clear
    else
        clear
        echo '  Mi dispiace non vi piacciano le mie opzioni'
        echo '  potremmo programmarne di nuove insime, che ne dite?'
        pingu
        sleep 3
        clear
    fi
fi

echo '  Ora vi lascio ragazzi, a presto!!!'
pingu

sleep 2
clear
echo '  Dai Stefano! spiegagli come funziono!'
pingu
exit
