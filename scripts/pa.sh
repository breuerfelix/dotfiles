# executes commands for all sinks
for SINK in `pacmd list-sinks | grep 'index:' | cut -b12-`
do
  pactl $1 $SINK $2
done
