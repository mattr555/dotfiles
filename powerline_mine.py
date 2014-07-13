# vim:fileencoding=utf-8:noet

from subprocess import Popen, PIPE
import re
import logging
import os
import subprocess

def internal_ip(pl):
    logging.warn('called')
    s = Popen('/sbin/ifconfig', stdout=PIPE).communicate()[0]
    matches = re.findall(r'inet addr:(\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b)', s)
    logging.warn(matches)
    if not matches:
        return None
    for i in matches:
        if i.startswith('192.168.') or i.startswith('172.16.') or i.startswith('10.'):
	    return [{'contents': i, 'divider_highlight_group': 'background:divider', 'highlight_group': 'external_ip'}]
            #return i

STATE_SYMBOLS = {
    'fallback': '♫',
    'play': '▶',
    'pause': '▌▌',
    'stop': '■',
}

def player_pianobar(pl, format="{state_symbol} {artist} - {title}"):
    if not os.popen('ps -Af').read().count('pianobar'):
        return
    artist, title = '', ''
    state = 'fallback'
    try:
        with open(os.path.join(os.getenv('HOME'), '.config/pianobar/nowplaying')) as f:
            artist, title = f.read().strip().split(' - ')
            title = title.replace('(like)', '♥')
        with open(os.path.join(os.getenv('HOME'), '.config/pianobar/isplaying')) as f:
            state = bool(int(f.read().strip()))
            if state:
                state = 'play'
            else:
                state = 'pause'
    except:
        pass

    content = format.format(**{
            'artist': artist,
            'title': title,
            'state': state,
            'state_symbol': STATE_SYMBOLS[state]
    })

    return [{'contents': content, 'highlight_group': 'now_playing'}]



def get_git_status():
    import os
    has_pending_commits = True
    has_untracked_files = False
    origin_position = ""
    output = subprocess.Popen(['git', 'status', '--ignore-submodules'],
            env={"LANG": "C", "HOME": os.getenv("HOME")}, stdout=subprocess.PIPE).communicate()[0]
    for line in output.split('\n'):
        origin_status = re.findall(
            r"Your branch is (ahead|behind).*?(\d+) comm", line)
        if origin_status:
            origin_position = " %d" % int(origin_status[0][1])
            if origin_status[0][0] == 'behind':
                origin_position += u'\u21E3'
            if origin_status[0][0] == 'ahead':
                origin_position += u'\u21E1'

        if line.find('nothing to commit') >= 0:
            has_pending_commits = False
        if line.find('Untracked files') >= 0:
            has_untracked_files = True
    return has_pending_commits, has_untracked_files, origin_position


def git(pl):
    # See http://git-blame.blogspot.com/2013/06/checking-current-branch-programatically.html
    p = subprocess.Popen(['git', 'symbolic-ref', '-q', 'HEAD'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    out, err = p.communicate()

    if 'Not a git repo' in err:
        return None

    if out:
        branch = out[len('refs/heads/'):].rstrip()
    else:
        branch = '(Detached)'

    has_pending_commits, has_untracked_files, origin_position = get_git_status()
    branch += origin_position
    if has_untracked_files:
        branch += ' +'

    colors = ['branch']
    colors.insert(0, 'branch_dirty' if has_pending_commits else 'branch_clean')

    return [{'contents': branch, 'highlight_group': colors}]

