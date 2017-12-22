
#ODBC setup
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/16.10/prod.list > /etc/apt/sources.list.d/mssql-release.list
apt-get update
ACCEPT_EULA=Y apt-get install -y msodbcsql
ACCEPT_EULA=Y apt-get install -y mssql-tools
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
alias brc='source ~/.bashrc'
apt-get install -y unixodbc-dev

#nginx setup
cp /home/deepquote /etc/nginx/sites-available/deepquote
ln -s /etc/nginx/sites-available/deepquote /etc/nginx/sites-enabled

