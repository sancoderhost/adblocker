# Adhost 

Introducing Adhost2, a lightweight ad blocker that uses a simple shell script to set up the host file. With no bells and whistles, Adhost2 efficiently blocks unwanted ads on your system, providing a faster and smoother browsing experience. Whether you're tired of pop-ups, banners, or other pesky ads, Adhost2 has got you covered.

Here's a README file in Markdown format based on the script you provided:

## How it works 

Adhost2 is a script that updates the /etc/hosts file on a Linux system with a list of hosts obtained from a file or custom input. It can be used to block or redirect hosts.

## Usage

Run the script with sudo privileges:

```bash
sudo ./adhost2
```

If you want to use a custom host list, specify the file path using the -h option:

```bash
sudo ./adhost2 -h /path/to/custom-host-list
```

To uninstall Adhost2 and restore the original /etc/hosts file, run:

```bash
sudo ./adhost2 uninstall
```

## Prerequisites

- Linux system
- Curl

## Notes

- The script must be run from the hosts directory (hint: from the unzip dir).
- If you interrupt the script with Ctrl+C, it will restore the original /etc/hosts file.
- The script must be run with sudo privileges.
- The default host list is /usr/share/adhost/adhost2.

## License

This script is licensed under the MIT License.
