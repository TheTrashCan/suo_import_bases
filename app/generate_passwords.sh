#!/bin/bash

sshpass -p "ffLukwVcErAod3t" ssh -o StrictHostKeyChecking=no vagrant@10.128.26.1 'cd /var/www/suo_prod/current/lib/tasks; rm -f passwords.rake'
sshpass -p "ffLukwVcErAod3t" scp -o StrictHostKeyChecking=no passwords.rake vagrant@10.128.26.1:/var/www/suo_prod/current/lib/tasks
sshpass -p "ffLukwVcErAod3t" ssh -o StrictHostKeyChecking=no vagrant@10.128.26.1 'cd /var/www/suo_prod/current; RAILS_ENV=production bundle exec rake passwords:generate'
sshpass -p "ffLukwVcErAod3t" scp -o StrictHostKeyChecking=no vagrant@10.128.26.1:/var/www/suo_prod/current/pas_id* /new/suo_import_bases/passwords/
