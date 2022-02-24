
It is a script that can run on linux for a hasicorp's consul product in the kubernetes environment.

In the first step of the script, you need to write the namespace information where the consul will run.You can set them in the variables below.

```namespace=consul </br>
BACKUP_SNAP_FILE="consul-snap-$( date +"%d-%m-%y").snap"</br>
BACKUP_KV_FILE="consul-kv-$( date +"%d-%m-%y").json"</br>
BACKUP_KEY_VALUE_FILE="consul-key-value-$( date +"%d-%m-%y").json"</br>
BACKUP_KEY_VALUE_JQ_FILE="consul-key-value-jq-$( date +"%d-%m-%y").json"</br>
BACKUP_TOKEN_FILE="consul-token-$( date +"%d-%m-%y").json"</br>
BACKUP_PATH="consul-backup-$(date +"%d-%m-%y")"</br>
BACKUP_POLC_FILE="consul-POLC-$( date +"%d-%m-%y")"</br>
```
After git clone operation, it will be enough to run the following command.

`git@github.com:ErdemERDOLU/kubernetesconsulbackup.git`

`chmod +x kubernetesconsulbackup/consulbackupPerfx.sh`

`./kubernetesconsulbackup/consulbackupPerfx.sh`

![image](https://user-images.githubusercontent.com/48557863/155588690-76c8722e-f44d-4693-b4c3-8db665c282e5.png)
