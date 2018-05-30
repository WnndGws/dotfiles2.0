import os.path
import subprocess
home = os.path.expanduser("~")
def mailpasswd(acct):
    path = "%s/.config/neomutt/mail_credentials.gpg" % (home)
    args = ["gpg2", "--use-agent", "--quiet", "--batch", "-d", path]
    try:
        return subprocess.check_output(args).strip()
    except subprocess.CalledProcessError:
        return ""
