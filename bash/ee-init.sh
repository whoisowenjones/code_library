#!/bin/bash
#
# Sets file and folder permissions of a fresh ee install
# Run from root directory

chmod 666 "./system/expressionengine/config/config.php"
chmod 666 "./system/expressionengine/config/database.php"
chmod 777 "./system/expressionengine/cache/"
chmod 777 "./images/avatars/uploads/"
chmod 777 "./images/captchas/"
chmod 777 "./images/member_photos/"
chmod 777 "./images/pm_attachments/"
chmod 777 "./images/uploads/"