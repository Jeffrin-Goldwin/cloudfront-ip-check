# Cloudflare IPv4 CIDR Change Tracker

This simple Bash script checks for changes in the Cloudflare IPv4 CIDR list and notifies you if there are any new or removed IP ranges.

It helps network administrators or DevOps engineers keep track of IP changes that may affect firewall rules, access control lists (ACLs), or CDN configurations.

🔧 Features
- Fetches the current Cloudflare IPv4 CIDR list.
- Compares it with the last cached list.
- Prints new and removed IPs if any changes are detected.
- Creates a cache on the first run to track changes over time.

📦 Prerequisites
- Bash shell
- curl
- jq (for JSON parsing)
- Unix-based system (Linux/macOS)

Install ```jq``` if you don't have it:

```
# Debian/Ubuntu
sudo apt install jq

# macOS
brew install jq
```

🚀 How to Use
1. Clone this repo:
```
https://github.com/Jeffrin-Goldwin/cloudfront-ip-check.git
cd cloudflare-ip-check
```

2. Make the script executable:
```
chmod +x cloudflare_ip_check.sh
```

3. Run the script:
```
./cloudflare_ip_check.sh
```

- On the first run, it will initialize a cache file cf_ipv4_cache.txt.

- On subsequent runs, it compares the latest Cloudflare IPv4 list against the cached version.

- If there are changes, it prints the newly added and removed IPs with a timestamp.

🗂 Output
- Cache file: cf_ipv4_cache.txt

- Temporary files are automatically cleaned up after each run.

- Timestamped log message is printed to the console if changes are detected.

📝 Example Cron Job
Run the check every 6 hours:
```
0 */6 * * * /path/to/check_cf_ipv4.sh >> /var/log/cloudflare_ip_monitor.log 2>&1
```

📄 License
MIT License – use it freely in personal or commercial projects.

🤝 Contributions
Feel free to submit issues or pull requests to improve this script!