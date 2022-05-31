#Credit: https://www.linkedin.com/in/abdul-hasif-abdul-rahman-0a65aab9/
#Registering RHEL host into Red Hat Satellite

#Verify Satellite https port 
nc -v ip_address_of_internal_Redhat_Satellite 443

#Verify if RHEL host registered or not
subscription-manager identity

#Unregistered incase RHEL host already registered in Satellite (but not workable)
clear && insights-client --unregister && subscription-manager unregister && subscription-manager remove --all && subscription-manager clean

#Verify if DNS of Satellite IP Address already declared in /etc/hosts
egrep ip_address_satellite /etc/hosts

#Declare DNS of Satellite and redirect output into /etc/hosts
echo "#Satellite" >> /etc/hosts

#Download Red Hat Satellite certs and perform localinstall
cd /home/working_wheel_account && curl --insecure --output katello-ca-consumer-latest.noarch.rpm https://ip_address_of_RedHat_Satellite/pub/katello-ca-consumer-latest.noarch.rpm

yum localinstall katello-ca-consumer-latest.noarch.rpm

#Register subscription-manager according environment declared in Red Hat Satellite
#For example:

subscription-manager register --org="Organization_Name_Declared_in_Satellite" --activationkey="rhel6/7/8" && subscription-manager repos --enable= * && yum -y install katello-host-tools katello-host-tools-tracer katello-agent sysstat yum-utils net-tools nc insight-client && insight-client --register && yum update -y 