newhost-ssh

I just started learning how to work with Proxmox.  I'm now stumbling into the world of Ansible.  
I'm currently watching a series of YouTube videos 
(playlist URL: https://youtube.com/playlist?list=PLT98CRl2KxKEUHie1m24-wkyHpEsa4Y70&si=Vz2yYgzmgs0M-yCW)
courtesy of YouTube Channel Learn Linux TV and the author's first complaint is that you must first
connect to the newly minted SSH server manually before proceeding, as SSH cannot establish the
authenticity of the host on first connect.

This BASH script aims to make that no longer a problem.  The basic framework is here so that you can
integrate it into your own workflow.  This script is meant as a place from which to start to integrate
into your own solution.
