
--- leandro

function onThink(interval)
 print('>> Memory cleaning in progress.' )
 os.execute("sh /home/warzona/liberamemoria.sh")
 		--- isso é simples basta coloca o caminho do arquivo  liberamemoria.sh
 return true
end