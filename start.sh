#!/bin/bash

# script pra rodar novamente o server automático em caso de crash
echo "Iniciando o programa"


cd /home/otserver
mkdir -p logs

#configs necessárias para o Anti-rollback
ulimit -c unlimited
set -o pipefail
CAMINHO="logs"
NOMEBACKUP="Zenonia"
USER="root"
SENHA="J4K39090"
BANCO="otserv"
TEMPO="$(date +'%d-%m-%Y-%H-%M')"



while true 		#repetir pra sempre
do
 	#roda o server e guarda o output ou qualquer erro no logs
	#PS: o arquivo antirollback_config deve estar na pasta do tfs	
	gdb --batch -return-child-result --command=antirollback_config --args ./tfs 2>&1 | awk '{ print strftime("%F %T - "), $0; fflush(); }' | tee "logs/$(date +"%F %H-%M-%S.log")"
	if [ $? -eq 0 ]; then							 
		echo "Exit code 0, aguardando 3 minutos..."	 #pra ser usado no backup do banco de dados
		
		echo *******BACKUP3********
		mysqldump -u$USER -p$SENHA $BANCO > $CAMINHO"/"$NOMEBACKUP"-"$TEMPO".sql"
		
		echo *******BACKUP1********
		git add .
		git commit -m "autobackup"
		git push
		
	echo *******BACKUP3********
		mysqldump -u$USER -p$SENHA $BANCO > $CAMINHO"/"$NOMEBACKUP"-"$TEMPO".sql"
	
	echo *******BACKUP1********
		git add .
		git commit -m "autobackup"
		git push
		
		sleep 5										
	fi												
done;                  
