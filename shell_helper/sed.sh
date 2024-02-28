sed -i 's/user  datagrand/user  root/g' custom_conf/extract_admin_html/nginx.conf
sed -i 's/user: datagrand/user: root/g' compose/*.yml


split -b 1000MB 文件名
cat x* > 文件名