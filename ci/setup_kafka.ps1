rm c:\temp\kafka_2.11-0.10.1.1.tgz
rm c:\temp\kafka_2.11-0.10.1.1.tar

$strFolderName="c:\temp\kafka_2.11-0.10.1.1"
If (Test-Path $strFolderName){
	Remove-Item $strFolderName -Force -Recurse
}

rm c:\temp\zookeeper-3.4.9.tar.gz
rm c:\temp\zookeeper-3.4.9.tar

$strFolderName="c:\temp\zookeeper-3.4.9"
If (Test-Path $strFolderName){
	Remove-Item $strFolderName -Force -Recurse
}

$client = New-Object System.Net.WebClient
$client.DownloadFile( "http://mirror.nexcess.net/apache/kafka/0.10.1.1/kafka_2.11-0.10.1.1.tgz", "c:\temp\kafka_2.11-0.10.1.1.tgz" )
C:\"Program Files"\7-Zip\7z e -oc:\temp\ c:\temp\kafka_2.11-0.10.1.1.tgz
C:\"Program Files"\7-Zip\7z x -oc:\temp\ c:\temp\kafka_2.11-0.10.1.1.tar

$client.DownloadFile( "http://download.nextag.com/apache/zookeeper/zookeeper-3.4.9/zookeeper-3.4.9.tar.gz", "c:\temp\zookeeper-3.4.9.tar.gz")
C:\"Program Files"\7-Zip\7z e -oc:\temp\ c:\temp\zookeeper-3.4.9.tar.gz
C:\"Program Files"\7-Zip\7z x -oc:\temp\ c:\temp\zookeeper-3.4.9.tar

$env:JAVA_HOME = "C:\Program Files\Java\jdk1.8.0_121"
$env:PATH += $env:JAVA_HOME+"\bin"

copy c:\temp\zookeeper-3.4.9\conf\zoo_sample.cfg c:\temp\zookeeper-3.4.9\conf\zoo.cfg
(Get-Content c:\temp\zookeeper-3.4.9\conf\zoo.cfg).replace('/tmp/zookeeper', '/temp/zookeeper-3.4.9/data') | Set-Content c:\temp\zookeeper-3.4.9\conf\zoo.cfg 

Start-Process -FilePath c:\temp\zookeeper-3.4.9\bin\zkserver

Start-Process -FilePath c:\temp\kafka_2.11-0.10.1.1\bin\windows\kafka-server-start.bat -ArgumentList 'c:\temp\kafka_2.11-0.10.1.1\config\server.properties' -NoNewWindow

C:\temp\kafka_2.11-0.10.1.1\bin\windows\kafka-topics --create --zookeeper localhost:2181/kafka --replication-factor 1 --partitions 1 --topic testtock


