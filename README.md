# newhost-ssh

## Introduction
I just started learning how to work with Proxmox and am now stumbling into the world of [Ansible](https://www.ansible.com/). I'm currently watching a series of YouTube videos by [Learn Linux TV](https://youtube.com/playlist?list=PLT98CRl2KxKEUHie1m24-wkyHpEsa4Y70&si=Vz2yYgzmgs0M-yCW). The author's first complaint is the requirement to manually connect to a newly minted SSH server before proceeding, as SSH cannot establish the authenticity of the host on the first connect.

## Purpose
This BASH script aims to make that initial connection hurdle no longer a problem. The basic framework is here so that you can integrate it into your own workflow. This script is meant as a starting point from which to develop and integrate into your own solution.

## How to Use
If you just launch the script ./newhost-ssh, you'll be prompted for the IP address of the host whose keys you want to retain.  The default is set to retrieve the ed25519 key, but you can change the variable at the top of the script to other keytypes. They're separated by a comma with no spaces if you want multiples, e.g. rsa,dsa,ed25519.
You can put an IP Address as one command line argument and the script will handle it without asking you for an IP address in that instance.

## Contributions
Feel free to branch/clone or whatever you want to do to improve this idea.  It's very rudamentary but I believe it to help solve a problem.

## License
Do whatever you want with this code. I never expected to make any money on it.  I'm always willing to accept compensation for my ideas and work, but at this point, there's no way I can expect it.  Everyone's broke, including me.
