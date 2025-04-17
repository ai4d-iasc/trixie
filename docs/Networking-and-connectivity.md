# Network Connectivity

This document indicates how users can connect to Trixie as well as other network information.

## Accessing Trixie

The Trixie head node can be accessed from within NRC via SSH on NRC Legacy (black) and the Secure
Research Netowrk (orange).

Trixie can also be accessed external to NRC using the Bastion host. Please see the
`External Access Setup` link in the [Related Topics section below](#related-topics)

## Outbound SSH Access to External Sites

The Trixie head node has outbound SSH access to a limited number of external sites (e.g. some
Canadian Universities). If you require access to an additional site which is not currently
available, create a request via [our issues page](https://github.com/ai4d-iasc/trixie/issues)

## Cloning Git Projects

You can clone Git projects into your Trixie directory from several Git servers. The table below
indicates the current servers and what type of access is enabled.

| Git Server | SSH    | HTTPS                        |
| ---------- | ------ | ---------------------------- |
| gitlabc    | Yes    | Yes - requires access tokens |
| git-collab | Broken | Yes - requires access tokens |
| gitlab.res | Yes    | Yes                          |
| github     | Yes     | Yes                          |

### Using Access Tokens for Gitlabc and Git-Collab

MFA is enforced on gitlabc and git-collab, which means you will not be able to pull using HTTPS the
standard way. If you do not want to set up SSH keys and would like to pull using HTTPS, the
following procedure describes the method for accessing these servers using HTTPS and an access
token.

1. Create an access token on gitlabc or git-collab
    1. Log in to your GitLab account
    1. Go to your **Profile** settings
    1. Go to **Access tokens**
    1. Choose a name and optionally an expiry date for the token
    1. Choose the desired scopes (api access)
    1. Click on **Create personal access token**
    1. Save the personal access token **somewhere safe**. Once you leave or refresh the page, you
       won't be able to access it again.
1. Clone your Git project<br>
   ``git clone https://oauth2:PERSONAL_ACCESS_TOKEN@gitserver.nrc.gc.ca/namespace/projectname.git``
    - Replace `PERSONAL_ACCESS_TOKEN` with the token you have generated
    - Replace `gitserver` with either `gitlabc` or `git-collab`
    - Replace `namespace` with the appropriate group or personal name space
    - Replace `projectname` with the name of your project

## Related Topics

[External Access Setup](External-Access-Setup.md)

[External Access Advanced Configuration](External-Access-Advanced-Configuration.md)
