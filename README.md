# Bilibili-source@1.1.4
BillBill live source catch (以下简称bch)哔哩哔哩直播源抓取<br>

BCH是一款专用于抓取哔哩哔哩生放送直播源的插件，可以通过uid及cid来进行对目标直播源的抓取。

!!单线程警告!!

# 安装方法:
本项目需要[ffmpeg]支持<br>
git clone本项目到工作目录后<br>
cd进该文件夹<br>
并输入sh install.sh进行安装<br>
再输入source /etc/profile与source ~/.bashrc使环境变量生效即可<br>
输入bch -v弹出版本信息即为安装成功<br>

* 快捷命令:<br>
`git clone https://github.com/LingkongSky/Bilibili-source.git`<br>
`cd Bilibili-source`<br>
`sudo sh install.sh`<br>
`source /etc/profile`<br>
`source ~/.bashrc`<br>
或者通过:
`wget https://github.com/LingkongSky/Bilibili-source/releases/download/BCH1.1.4/Bilibili-Source-1.1.4.zip -O Bilibili-Source`<br>
`unzip Bilibili-Source`<br>
`cd Bilibili-Source-1.1.4`<br>
`sudo sh install.sh`<br>
`source /etc/profile`<br>
`source ~/.bashrc`<br>
来下载并安装最新版本

# 更新方法:
当你的主机可直连至github时，可以使用bch -update来进行自动更新。当你的主机无法连接至github时，bch将会自动切换到备用线路:`www.smallpipe.xyz/bch/`<br>
你也可以通过下载最新的release包来进行覆盖更新。<br>
# 使用说明:
通过`bch -cid [cid]`来锁定对象<br>
!!!无论是-start或-t和-settime，其目标都以执行命令时锁定的目标为主。<br>
你可以通过`bch -target`来查看锁定目标。<br>
再输入`bch -start`即可<br>
为防止无限期抓取，BCH相应的设置了最大时间与最大文件大小，你可以在setting文件中对其进行更改。<br>

bch的基础设置为无损原画抓取。<br>
通过输入`bch -anc [cid]`和`bch -anu [uid]`，你可以获取到对应up主的昵称，uid，cid，房间名与直播间地址并会被收录进user_data。<br>
通过bch -data来查看已收录的up主信息。<br>
你可以通过输入`bch -t [maxtime:s]`来指定抓取时间。<br>
亦或是输入bch -now查看是否有进程正在抓取及通过bch -stop来停止抓取并保存。<br>

如果想要定时执行抓取，可以通过输入`bch -settime [MM-DD-HH]`  以[月份-日期-小时]的格式对指定目标进行定时抓取，以机器时间为准，到达对应时间点后将会以每分钟一次的频率发送抓取请求，开始抓取时,定时任务自动删除并结束。也可以通过bch -task来查看定时任务。<br>

保存文件以时间格式命名。如`02-02_06-47`，且会保存到默认地址{工作地点}/results目录下。<br>
你可以通过bch -setting来查看bch配置文件并进行更改。<br>
输入bch -set以编辑配置文件，对最大下载时间，文件大小，保存路径，下载速度进行设定与更改。<br>
输入`bch -path`以获取工作目录。<br>
你可以移除旧目录，并在git clone后更改install.sh中的工作目录指向来更改工作目录。<br>

# 指令说明
bch [-option]<br>
`-start` [需在bch -cid指定目标后使用]<br>
`-stop` [停止已有的抓取进程并保存]<br>
`-t [time:S]` [指定时间长度抓取，大小为S]<br>
`-settime [MM-DD-HH]` [定时执行抓取任务]<br>
`-task` [查看是否有定时抓取任务存在]<br>
`-path` [查看当前的工作目录]<br>
`-now` [查看正在进行的抓取进程信息]<br>
`-anu [uid]` [通过用户uid收集信息并收录进user_data]<br>
`-anc [cid]` [通过用户cid收集信息并收录进user_data]<br>
`-cid [cid]` [指定抓取目标cid]<br>
`-data` [查看已抓取的信息]<br>
`-target` [查看指定目标]<br>
`-setting` [查看配置文件]<br>
`-set` [编辑配置文件]<br>
`-update` [自动更新至最新版本]<br>
`-help` [查看指令帮助]