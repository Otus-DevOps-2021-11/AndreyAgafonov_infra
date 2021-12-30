#!/bin/bash
# ya_zone="ru-central1-a"
# ya_sub_net_id="e9b3clbb9f2diuimkieu"
work_dir=$(dirname "$0")
ya_image_id="fd8rcdm2bipjtnq98atn"
ya_machine_name="reddit-full"

yc compute instance create \
  --name $ya_machine_name \
  --cores 2 \
  --core-fraction 50 \
  --memory 2 \
  --create-boot-disk image-id=$ya_image_id,auto-delete=yes,size=10GB \
  --public-ip \
  --metadata-from-file user-data=$work_dir/../../config-scripts/cloud-config


echo -e "\e[1;32m For result - see URL:"
echo -e "\e[1;32m http://"$(yc compute instance get $ya_machine_name --format json |jq -r '.network_interfaces[0].primary_v4_address.one_to_one_nat.address')":9292"
tput sgr0
