for user in james john mary
do
    (echo USER ${user}; sleep 2s; echo PASS {PASSWORD}; sleep 2s; echo LIST; sleep 2s; echo quit) | nc -nvC {IP} 110;
done
