# Bilibili-source@1.0.0
BillBill live source catch (以下简称bch)哔哩哔哩直播源抓取

BCH是一款专用于抓取哔哩哔哩生放送直播源的插件，可以通过uid(用户id)及cid(用户房间号)来进行对目标直播源的抓取。

!!单线程警告!!

# 安装方法:
需要[ffmpeg]支持
git clone本项目到工作目录后
cd进该文件夹
输入sh install.sh进行安装
再输入source /etc/profile使环境变量生效即可
输入bch -v弹出版本信息即为安装成功

# 使用说明:
通过bch -cid [目标直播间号码]来锁定对象
!!!无论是-start或-t和-settime，其目标都以执行命令时锁定的目标为主。
你可以通过bch -target来查看锁定目标。
再输入bch -start即可
为防止无限期抓取，BCH相应的设置了最大时间与最大文件大小，你可以在setting文件中对其进行更改。
如果想要设置定时抓取，可以使用bch -settime [MM-DD-HH]，只需设定月份，日期与小时即可。在系统时间到达设定时间时，bch会以分钟为尺度进行1小时的请求发送，并在成功反馈后开始抓取。

bch的基础设置为无损原画抓取。
通过输入bch -anc [cid]和bch -anu [uid]，你可以获取到对应up主的昵称
uid，cid，房间名与直播间地址并会被收录进user_data。
通过bch -data来查看已收录的up主信息
你可以通过输入bch -t [maxtime:s]来指定抓取时间
亦或是输入bch -now查看是否有进程正在抓取及通过bch -stop来停止抓取并保存。

如果想要定时执行抓取，可以通过输入bch -settime [MM-DD-HH]  以[月份-日期-小时]的格式对指定目标进行定时抓取，以机器时间为准，到达对应时间点后将会以每分钟一次的频率发送抓取请求，开始抓取时定时任务结束。也可以通过bch -task来查看定时任务。

保存文件以时间格式命名02-02_06-47，且会保存到默认地址{工作地点}/results目录下。
你可以通过bch -setting来查看bch配置文件并进行更改。
输入bch -p以获取工作目录。
你可以移除旧目录，并在git clone后更改install.sh中的工作目录指向来更改工作目录。

# 指令说明
bch [-option]
`-start` [需在bch -cid指定目标后使用]
`-stop` [停止已有的抓取进程并保存]
`-t [time:S]` [指定时间长度抓取，大小为S]
`-settime [MM-DD-HH]` [定时执行抓取任务]
`-task` [查看是否有定时抓取任务存在]
`-path` [查看当前的工作目录]
`-now` [查看正在进行的抓取进程信息]
`-anu [uid]` [通过用户uid收集信息并收录进user_data]
`-anc [cid]` [通过用户cid收集信息并收录进user_data]
`-cid [cid]` [指定抓取目标cid]
`-data` [查看已抓取的信息]
`-target` [查看指定目标]
`-setting` [查看配置文件]
`-help` [查看指令帮助]