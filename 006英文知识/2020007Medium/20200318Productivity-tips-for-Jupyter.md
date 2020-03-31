# Productivity tips for Jupyter (Python)

Michał Krassowski

Mar 18, 2019 · 6 min read

[Productivity tips for Jupyter (Python) - Towards Data Science](https://towardsdatascience.com/productivity-tips-for-jupyter-python-a3614d70c770)

I’ve been very busy working on my MRes project in recent weeks, having very little sleep. This made me seek ways to improve my workflow in the most important tool of my work: Jupyter Notebook/Jupyter Lab. I collected all the hacks & tips in this piece, hoping that other researchers may find those useful:

Note: To make it easy-to-use, I collected the snippets presented below into a Python3 package (jupyter-helpers). You can get it with:

    pip3 install jupyter_helpers

It will work out of the box, but if you wish the best experience, these dependencies are highly recommended:

    pip3 install ipywidgets
    jupyter labextension install @jupyter-widgets/jupyterlab-manager

## 01. Play a sound once the computations have finished

You can configure your Jupyter to play a sound if the execution of the cell (or strand of cells) took more than a few seconds. I have previously described two methods for that, a Python-based one, and a JavaScript one. The code for the python one roughly goes like:

```
from time import time
from IPython import get_ipython
from IPython.display import Audio, display

class Beeper:

    def __init__(self, threshold, **audio_kwargs):
        self.threshold = threshold
        self.start_time = None    # time in sec, or None
        self.audio = audio_kwargs

    def pre_execute(self):
        if not self.start_time:
            self.start_time = time()

    def post_execute(self):
        end_time = time()
        if self.start_time and end_time - self.start_time > self.threshold:
            audio = Audio(**self.audio, autoplay=True)
            display(audio)
        self.start_time = None

beeper = Beeper(5, filename='beep-07.wav')

ipython = get_ipython()
ipython.events.register('pre_execute', beeper.pre_execute)
ipython.events.register('post_execute', beeper.post_execute)
```

However, the helpers package got an upgraded version which takes care of hiding the Audio player and many other things. Use it like this:

```
from jupyter_helpers.notifications import Notifications
Notifications(
     success_audio='path/to/beep-07.wav', time_threshold=2
)
```

In the example above, I use beep-07.wav from soundjay.com. If you use Ubuntu or another distribution with GNOME, you can provide a path to one of the default alert sounds, e.g. /usr/share/sounds/gnome/default/alerts/bark.ogg.

### Play a honk sound on exception

Similarly, you can add a hook to play a different sound when an exception is raised. Here is a very simple mechanism proposed by Kevin at SO:

```
# CC-BY-SA 4.0 Kevin (https://stackoverflow.com/a/41603739/6646912)
# https://creativecommons.org/licenses/by-sa/4.0/
from IPython.display import Audio, display

def play_sound(self, etype, value, tb, tb_offset=None):
    self.showtraceback((etype, value, tb), tb_offset=tb_offset)
    display(Audio(url='http://www.wav-sounds.com/movie/austinpowers.wav', autoplay=True))

get_ipython().set_custom_exc((ZeroDivisionError,), play_sound)
```

And of course a more advanced one is part of the jupyter_helpers package:

```
from jupyter_helpers.notifications import Notifications
Notifications(failure_audio='path/to/beep-05.wav')
```

## 02. Integrate notifications with your OS

When working from library I needed an alternative for beeps and honks. Notify-send turned our to be a perfect tool for me as a primarily GNOME user (scroll down for instructions for other desktop environments).

To set things up use:

```
from jupyter_helpers.notifications import Notifications
Notifications(
    success_audio='path/to/beep-07.wav', time_threshold=2,
    failure_audio='path/to/beep-05.wav',
    integration='GNOME'
)
```

This will work out of the box for GNOME users, though installing a drop-in replacement called notify-send.sh will make the notifications go away once they are no longer needed. This can be done with attached setup.sh script.

The OS integration is ready to be hooked for any other desktop environment, though it will require some scripting:

```
from jupyter_helpers.desktop_integration import DesktopIntegration
class WindowsIntegration(DesktopIntegration):
    def notify(self, title, text, notify_id=None, **kwargs):
        pass   # add your code here
    def notify_close(self, notify_id):
        pass   # add your code here
Notifications(
    success_audio='path/to/beep-07.wav', time_threshold=2,
    failure_audio='path/to/beep-05.wav',
    integration=WindowsIntegration
)
```

Please consider sending a PR if you wish to integrate it with your OS.

## 03. Jump to definition of a variable/function/class

Use Alt + click to jump to a definition using your mouse, or Ctrl + Alt + B keyboard-only alternative with jupyterlab-go-to-definition extension:

Jump-to-definition supports Python and R. PRs to support other languages are welcome

Finally, use Alt+ o to jump back to your previous location:

The ability to jump back is quite helpful for notebooks with longer outputs

To install the extension use:

    jupyter labextension install @krassowski/jupyterlab_go_to_definition

2020 update: even more robust jumping is now available with jupyterlab-lsp!

## 04. Enable auto-completion for rpy2 (ggplot2!)

If your work is more about publications rather than interactive dashboards, there is a good chance you are familiar with ggplot2. While there are some great projects like plotnine which attempt to port it to Python, I still find working with ggplot (especially the extensions) more feature-complete when using rpy2 R-Python interface.

However, auto-completion did not include the R objects (nor ggplot functions if loaded) in %%R cells so far. I prepared a simple workaround:

```
from rpy2.robjects import r
from IPython import get_ipython

def rpy2_completer(ipython, event):
    query = event.line.strip().split()[-1]
    suggestions = []
    all_r_symbols = r('sapply(search(), ls)')
    for environment, symbols in all_r_symbols.items():
        for _, symbol in symbols.items():
            if symbol.startswith(query):
                suggestions.append(symbol)
    return suggestions

get_ipython().set_hook('complete_command', rpy2_completer, re_key='.*')
```

It may be improved in the future, as discussed in this GitHub issue.

Again, one simple import from jupyter_helpers will solve the issue:

    from jupyter_helpers import rpy2_autocompletion

2020 update: can now be also accomplished with upyterlab-lsp!

## 5. Summarize dictionaries in a nice table view

This is not a novel idea, though I hope that sharing my more than less advanced class may help others. This is based on Python3 SimpleNamespace, but extends it with a pandas- and numpy- aware HTML representation for Jupyter:

```
from jupyter_helpers.namespace import NeatNamespace
NeatNamespace(your_dict)
```

Long collections will be trimmed, so no need to worry about the space or running out of memory when browsers struggle to render accidentally printed dictionary. Horizontal and vertical orientations are available for better space utilization.

Namespaces with HTML: when nested data needs to be looked at before converting to DataFrame

## 06. Selectively import from other notebooks

For some time I was trying to follow data/methods/results separation, having three Jupyter notebooks for each larger analysis: data.ipynb, methods.ipynb and results.ipynb. To save time on useless re-computation of some stuff I wanted to have selective import from data and methods notebooks for use in the results notebook.

It is now possible (building upon nbimporter) using one import and a magic:

This was described in this SO thread, and I still hope to see some suggestions.

[python - Selectively import from another Jupyter Notebook - Stack Overflow](https://stackoverflow.com/questions/54317381/selectively-import-from-another-jupyter-notebook)

## 07. Scroll to the recently executed cell

You may have noticed that previously shown Notifications class made the notebook scroll down on exception to the offending cell (Figure 1). This can be disabled by passing scroll_to_exceptions=False.

If you conversely, want more auto-scrolling, you could use the underlying helper function to mark the cell that you ended working with at night to quickly open your notebook back on it in the morning:

```
from jupyter_helpers.utilities import scroll_to_current_cell
scroll_to_current_cell(preserve=True)
```

## 08. Interactive tail for long outputs

Lastly, when running third-party applications (but not being at the point of building a fully-fledged pipeline), one may want to see only the tail of the currently running process. In bash it is easily achieved using tail -f.

If you can relate to the need of watching the output and problem of it slowing down your computer when being flushed out to your notebook or just generating annoyingly long outputs, FollowingTail helper may be for you:

Apply tail -f equivalent to keep the outputs at reasonable length!

There is more to come!

I only had time for so much now, but I will be sharing more of already written and new helpers and snippets. This is a way of giving back to the amazing community of scientific computing (from both Python and R side) which enabled me to complete my thesis. I have another project to come, which will likely require to overcome other challenges.

Once more is ready I will be sharing the news on Twitter (@krassowski_m).