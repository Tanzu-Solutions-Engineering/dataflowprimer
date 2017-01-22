$client = New-Object System.Net.WebClient
$client.DownloadFile(http://repo.spring.io/snapshot/org/springframework/cloud/spring-cloud-dataflow-server-local/1.2.0.BUILD-SNAPSHOT/spring-cloud-dataflow-server-local-1.2.0.BUILD-SNAPSHOT.jar, df.jar)

$client.DownloadFile(http://repo.spring.io/snapshot/org/springframework/cloud/spring-cloud-dataflow-shell/1.2.0.BUILD-SNAPSHOT/spring-cloud-dataflow-shell-1.2.0.BUILD-SNAPSHOT.jar, dfshell.jar)

$env:JAVA_HOME = "C:\Program Files\Java\jdk1.8.0_121"
$env:PATH += $env:JAVA_HOME+"\bin"

Start-Process -FilePath java.exe -ArgumentList '-jar','df.jar','-classpath','$Env:CLASSPATH' -NoNewWindow