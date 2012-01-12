#!/bin/sh
echo "[info]  run multiple background proc."
echo "[info]  -----------------------------"

_dummy_proc(){
  sleep $1
  ret=`expr $1 % 2`
  exit $ret
}

_dummy_proc 2 &
pid1=$!

_dummy_proc 3 &
pid2=$!

_dummy_proc 5 &
pid3=$!

echo "[info]  pid1=$pid1, pid2=$pid2, pid3=$pid3"

wait $pid1
sc=$?
if [ 0 -ne $sc ]; then
  echo "[error] pid1=$pid1 finished with status code $sc"
  kill -KILL $pid2
  kill -KILL $pid3

  exit 1
else
  echo "[info]  pid1=$pid1 finished"
fi

wait $pid2
sc=$?
if [ 0 -ne $sc ]; then
  echo "[error] pid2=$pid2 finished with status code $sc"
  kill -KILL $pid3

  exit 1
else
  echo "[info]  pid2=$pid2 finished"
fi

wait $pid3
sc=$?
if [ 0 -ne $sc ]; then
  echo "[error] pid3=$pid3 finished with status code $sc"

  exit 1
else
  echo "[info]  pid3=$pid3 finished"
fi

echo "[info]  -----------------------------"
echo "[info]  finished all background proc."

exit 0