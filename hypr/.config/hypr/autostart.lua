-- Extra autostart processes.
-- o.launch_on_start("my-service")
o.launch_on_start("eval $(ssh-agent -s)")
o.launch_on_start("ssh-add ~/.ssh/id_ed25519")
