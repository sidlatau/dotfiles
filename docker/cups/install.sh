# https://expressittechtips.co.uk/piprintserver
# https://192.168.0.104:631/printers/Samsung_ML-2525W_Series

sudo apt install cups
sudo usermod -a -G lpadmin ts
sudo apt install libcupsimage2
sudo cupsctl --remote-admin --remote-any --share-printers
sudo apt install printer-driver-splix
sudo /etc/init.d/cups restart
