[Unit]
Description=ToDoApp
Requires=network-online.target
After=network-online.target

[Service]
Environment=MONGO_URL=mongodb://{{ db_url }}:27017/
WorkingDirectory={{ app_path }}
Type=simple
ExecStart=/usr/bin/node {{ app_path }}server.js
Restart=on-failure

[Install]
WantedBy=multi-user.target
