@cls
@title ROUTER-A
@attrib *.* -r
@REM --idle-pc=0x604f0090
@set loopback=\Device\NPF_{F2AE977A-F5C8-4A61-A23C-39DD1602529D}
@set IOS=..\ios\c7200-is-mz.19991126.bin
@set NPE=npe-100
@set RAM=64 -X

@attrib *.* -r
..\dynamips.exe -P 7200 %IOS%  ^
-m %RAM% ^
-t %NPE%  ^
-p 0:C7200-IO-FE ^
-p 1:PA-4E  ^
-s1:0:gen_eth:%loopback% ^
-s1:1:udp:5501:127.0.0.1:5000