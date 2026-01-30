#!/bin/bash


##### Annoying, Mac tries to use its own webserver... WHY???

# Blog that HELPED me
# https://www.sitelint.com/blog/macos-find-start-stop-and-restart-the-apache-web-server

# > which -a httpd

# > whereis httpd

# > which -a httpd

# > which -a httpd


#### Dealing with Internal Apache

### Didn't work - kept getting error
### Unload failed: 5: Input/output error
### Try running `launchctl bootout` as root for richer errors.
# > sudo /usr/sbin/apachectl stop

#### What did work
# > sudo apachectl graceful
# > sudo killall httpd && sudo launchctl unload /System/Library/LaunchDaemons/org.apache.httpd.plist
