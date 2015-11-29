#!/bin/bash

echo "Введите ip (10.128.8.47)"
read ip

set -x
sshpass -p "vagrant" scp -o StrictHostKeyChecking=no -v -P 8022 sshpass_1.05-1_amd64.deb vagrant@$ip:/home/vagrant
sshpass -p "vagrant" ssh -o StrictHostKeyChecking=no -v vagrant@$ip -p 8022 << !
  echo "vagrant" | sudo -S dpkg -i sshpass_1.05-1_amd64.deb
  sshpass -p "vagrant" ssh -o StrictHostKeyChecking=no -v vagrant@10.0.15.10 <<EOF
    pg_dump suo_local -t slots -t conversation_fs -t users -t board_settings -t office_settings -t offices -t portal_tickets -t day_schedules -t activities -t register_action_normatives -t service_normatives -t eq_tickets -t unloading_events -t classifier_versions -t feedback_forms -t slots_counters -t classifiers -t dictionaries -t feedback_question_answers -t changes -t client_infos -t office_checks -t counters -t report_parameters -t soms_settings -t system_settings -t documents -t settings -t day_schedule_resources -t resources_users -t offices_resources -t creeping_line_patterns -t resources -t services --no-privileges --no-acl --no-owner --data-only > db.sql
EOF
  sshpass -p "vagrant" scp -o StrictHostKeyChecking=no -v vagrant@10.0.15.10:db.sql /home/vagrant
!

sshpass -p "vagrant" scp -o StrictHostKeyChecking=no -v -P 8022 vagrant@$ip:db.sql /new/suo_import_bases/bases/$ip.sql
