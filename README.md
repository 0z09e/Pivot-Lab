# Pivot Lab  
> Developed by - 0z09e | Date - 01/10/2021  
***  
## Overview  
This repository can be used to create a simulation of a real life industrial network in which one box is exposed to the internet and other's are inside of a DMZ.  
In-order to access other boxes inside of that DMZ we need to to use a technique called `Pivoting`.  
For those of you who don't know what is pivoting, please follow the reference given below.  
## Lab Description  
Every lab has 2 ports open, port 22 and port 80.  
Port 80 has a page which contains a php webshell, pass the command using the parameter `cmd`.  
The port 80 of `target1` is exposed to public, start from `target1` and pivot all the way upto `target4`.  
This lab contains :  
- Pivoting  
- Double Pivoting  
  
  
## Lab Setup  
*Execute the above script in a Ubuntu vm not in your host machine*  
```bash  
bash build-lab.sh  
```  
To remove the lab from the vm :   
```bash  
bash destroy-lab.sh  
```  
  
## Reference :   
- [Tunneling and Port Forwarding by HackTricks](https://book.hacktricks.xyz/tunneling-and-port-forwarding)  
- [Network Pivoting using Metasploit and Proxychains](https://blog.pentesteracademy.com/network-pivoting-using-metasploit-and-proxychains-c04472f8eed0)  
- [Explore Hidden Networks With Double Pivoting](https://pentest.blog/explore-hidden-networks-with-double-pivoting/)  
-   
***  
  
  
  
  
