# Wi-Fi Fake (Hotspot) Setup

This script sets up a Wi-Fi fake hotspot using `hostapd` and `dnsmasq`. It also configures Apache to serve a captive portal page. Follow the steps below to use this script.

## Step 1: Clone the Repository

```bash
git clone https://github.com/rmmenezes/WifiFake.git
cd WifiFake
```

## Step 2: Run the Setup Script
```bash
chmod +x wifi.hs
sudo ./wifi.sh
```

The script will prompt you to enter the name of your Wi-Fi interface. It will then update the configuration files and start the necessary services.

## Step 3: Access the Captive Portal
Connect a device to the Wi-Fi hotspot and open a web browser. The captive portal page should be accessible at http://10.0.0.1.

## Important Notes:
The setup script requires administrative privileges, and you may be prompted to enter your password.

Ensure that the Wi-Fi interface is in the correct state before running the script (ifconfig -a).

The script stops the Network Manager service, so make sure to have an alternative means of network connectivity if needed.

The Apache service is configured to serve a basic captive portal page located in the captive-portal directory.

The script uses iptables to configure network forwarding.

## Additional Information:
This project is licensed under the MIT License. See LICENSE for details.

Contributions are welcome. If you encounter issues or have suggestions, please open an issue or submit a pull request.

Disclaimer: Be aware of the legal implications of creating Wi-Fi hotspots. Ensure you have the right to use the network interface and comply with local laws and regulations. The script is provided as-is, and the author takes no responsibility for its usage.