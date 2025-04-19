cd ../build; make; cd ..;

# config file
config=./configs/systolic_ws_128x128_dev.json
mem_config=./configs/memory_configs/neupims.json
model_config=./configs/model_configs/gpt3-175B-bs64-share-gpt-prev.json
sys_config=./configs/system_configs/sub-batch-on.json
cli_config=./data/share-gpt-prev-bs64-ms175B-tp16-pp4-clb-4.csv

# log file
LOG_LEVEL=info
DATE=$(date "+%F_%H:%M:%S")

# get the standard log dir
name="$0"
base_name=$(basename "$name")
folder_name="${base_name%.*}"
LOG_DIR=experiment_logs/${folder_name}

mkdir -p $LOG_DIR;
LOG_NAME=simulator.log
CONFIG_FILE=${LOG_DIR}/config.log

echo "log directory: $LOG_DIR"



./build/bin/Simulator \
    --config $config \
    --mem_config $mem_config \
    --cli_config $cli_config \
    --model_config $model_config \
    --sys_config $sys_config \
    --log_dir $LOG_DIR


echo "memory config: $mem_config" > ${CONFIG_FILE}
echo "client config: $cli_config" >> ${CONFIG_FILE}
echo "model config: $model_config" >> ${CONFIG_FILE}
echo "system config: $sys_config" >> ${CONFIG_FILE}
cat ${CONFIG_FILE}
