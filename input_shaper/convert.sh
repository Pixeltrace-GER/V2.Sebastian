#!/bin/bash
dir_date=$(date "+%Y%m%d_%H%M%S")
save_dir=/home/pi/klipper_config/input_shaper/$dir_date

echo 
echo "Usage Klipper Test Resonances:"
echo "TEST_RESONANCES AXIS=X"
echo "TEST_RESONANCES AXIS=Y"
echo "TEST_RESONANCES AXIS=1,1 OUTPUT=raw_data"
echo "TEST_RESONANCES AXIS=1,-1 OUTPUT=raw_data"
echo




raw_data=(/tmp/raw_data*.csv)
if [[ ${#raw_data[@]} -gt 1 ]]; then
	mkdir -p $save_dir
    mv /tmp/raw_data* $save_dir
	~/klipper/scripts/graph_accelerometer.py -c $save_dir/raw_data_axis*.csv -o  $save_dir/resonances.png
fi

if test -f /tmp/resonances_x*.csv; then
	mkdir -p $save_dir
    mv /tmp/resonances_x* $save_dir
    ~/klipper/scripts/calibrate_shaper.py $save_dir/resonances_x_*.csv -o  $save_dir/shaper_calibrate_x.png
fi

if test -f /tmp/resonances_y*.csv; then
	mkdir -p $save_dir
    mv /tmp/resonances_y* $save_dir
    ~/klipper/scripts/calibrate_shaper.py $save_dir/resonances_y_*.csv -o $save_dir/shaper_calibrate_y.png
fi

