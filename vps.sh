#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
Make_SSR(){
	yum -y install wget
	wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/ssr.sh && chmod +x ssr.sh && bash ssr.sh
}
Make_Plex(){
	wget  https://downloads.plex.tv/plex-media-server/1.13.9.5456-ecd600442/plexmediaserver-1.13.9.5456-ecd600442.x86_64.rpm    
	yum install plexmediaserver-1.13.9.5456-ecd600442.x86_64.rpm
}
Make_Aria2(){
	wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/aria2.sh && chmod +x aria2.sh && bash aria2.sh

}

Make_Caddy(){
	wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/caddy_install.sh && chmod +x caddy_install.sh && bash caddy_install.sh install http.filemanager
	mkdir /usr/local/caddy/www && mkdir /usr/local/caddy/www/file
	echo ":8000 {
 	root /usr/local/caddy/www/file
 	timeouts none
 	gzip
 	filemanager / /usr/local/caddy/www/file {
  	database /usr/local/caddy/filemanager.db
 	}
	}" > /usr/local/caddy/Caddyfile

}
Make_BBR(){
	wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && bash bbr.sh

}
start_service(){
	service caddy start
	firewall-cmd --permanent --zone=public --add-port=1000-50000/tcp
	firewall-cmd --permanent --zone=public --add-port=1000-50000/udp
	firewall-cmd --reload 


}





echo -e "  VPS一键管理脚本 ${Red_font_prefix}[v${sh_ver}]${Font_color_suffix}
  ----babaxiong----

  ${Red_font_prefix}1.${Font_color_suffix} 配置 ShadowsocksR
  ${Red_font_prefix}2.${Font_color_suffix} 配置 Plex
  ${Red_font_prefix}3.${Font_color_suffix} 配置 Aria2
  ${Red_font_prefix}4.${Font_color_suffix} 配置 Caddy
  ${Red_font_prefix}5.${Font_color_suffix} 配置 BBR
  ${Red_font_prefix}6.${Font_color_suffix} 启动 服务

"
echo && read -e -p "请输入数字 [1-5]：" abc
case "$abc" in
	1)
	Make_SSR
	;;
	2)
	Make_Plex
	;;
	3)
	Make_Aria2
	;;
	4)
	Make_Caddy
	;;
	5)
	Make_BBR
	;;
	6)
	start_service
	;;
	*)
	echo -e "${Error} 请输入正确的数字 [1-4]"
	;;
esac
