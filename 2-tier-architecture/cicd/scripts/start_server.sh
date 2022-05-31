#!/bin/bash

cd /opt/jar/

sudo chmod +x start_server.sh  stop_server.sh 

sudo systemctl start api.service

# sudo systemctl start engine.service

# sudo systemctl start scheduler.service

# sudo systemctl start configuration-server.service