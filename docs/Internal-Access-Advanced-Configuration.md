# Internal Access Advanced Configuration

## Overview

To ease usage of the bastion host to easily connect to Trixie, there are some steps which can be
taken, especially making use of the SSH **ProxyJump** and **ControlMaster** parameters. Basically,
you need to configure SSH to automatically connect with the Trixie server using the bastion host as
a connector between your local computer and the Trixie server.

**Important Note:** Before proceeding with this configuration, please ensure that you have
performed the [Internal Access Setup](Internal-Access-Setup.md) procedure.

## Mac OSX / Linux

To configure SSH to automatically connect to the Trixie server, please perform the following steps

1. Open your ``.ssh/config`` file with your preferred text editor and add the following lines on
   your local machine – not the servers – while substituting your given usernames in the **User**
   directive.<br>
   **TIP:** Some users have reported that using `doej` did not work for their **PUB** username.
   Please try using the first.last format - for example `john.doe` - for your **PUB** username if
   `doej` doesn't work for you

```
Host trixie-bastion
  HostName trixie.nrc-cnrc.gc.ca
  User <username>@pub.nrc-cnrc.gc.ca
  ForwardAgent true

Host trixie
  HostName trixie.res.nrc.gc.ca 
  User <username>
  ProxyJump trixie-bastion
```

Once your settings are configured, you will be able to login to the Trixie server with the
following command

``ssh trixie``

Please note that you will be prompted as follows

1. Prompt for your **PUB** password
1. *LoginTC* prompt – enter 1
1. Prompt for your **SRN** password

## Windows – Putty

To configure SSH to automatically connect to the Trixie server, please set the following settings
in your Putty application, substituting your username where applicable.

1. Under **Connection -> Proxy**
      1. From the **Proxy type** dropdown, select: *SSH to proxy and use port forwarding*
      1. Set **Proxy hostname**: *trixie.nrc-cnrc.gc.ca*
      1. Set **Port**: *22*
      1. Set **Username**: *<username\>@pub.nrc-cnrc.gc.ca*<br>
         **TIP:** Some users have reported that using `doej` did not work for their **PUB** username.
         Please try using the first.last format - for example `john.doe` - for your **PUB** username if
         `doej` doesn't work for you
      1. Leave **Password** blank - do not fill it in<br>
      ![trixie putty](images/trixie-putty-5.png)<br>
1. Under **Connection -> SSH -> X11**
      1. Select the option **Enable X11 forwarding**<br>
      ![putty](images/trixie-putty-2.png)<br>
1. Under **Session**
      1. Set **Host Name (or IP address)**: *<username\>@trixie.res.nrc.gc.ca*
      1. Set **Port**: *22*
      1. Add a name for **Saved Sessions** – perhaps *Trixie*<br>
      ![putty](images/trixie-putty-4.png)<br>
1. Click **Save**

Once the settings have been saved, you can double click on the name in the list of
**Saved Sessions** to open a session to the Trixie server. Please note that you will be prompted as
follows

1. Prompt for your **PUB** password
1. *LoginTC* prompt – enter 1
1. Prompt for your **SRN** password

## Related Topics

[Internal Access Setup](Internal-Access-Setup.md)<br>
[External Access Setup](External-Access-Setup.md)<br>
[External Access Advanced Configuration](External-Access-Advanced-Configuration.md)<br>
[File Transfers](File-Transfers.md)
