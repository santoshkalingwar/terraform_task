sudo cp springpetclinic.service /etc/systemd/system/springpetclinic.service
sudo chmod 755 springpetclinic.sh 
sudo chmod 755 javamaveninstallation.sh 
sudo chmod 755 startservice.sh
sudo sh javamaveninstallation.sh
sudo sh springpetclinic.sh
sudo sh startservice.sh

