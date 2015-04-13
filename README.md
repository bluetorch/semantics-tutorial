#Semantics Tutorial Project

This project contains data, queries, and a demo application to use during a
MarkLogic semantics tutorial.

It is a super quick-and-dirty MarkLogic application.

It uses an single HTML file, tutorial.html, and an OOTB MarkLogic REST server
on port 8000

#requires

* java
* curl  (provided for Windows)
* scripting ( sh or .bat )
* MarkLogic 8+ installed, running

#Quickstart

```
sh setup.sh
```

OR, on Windows

```
setup.bat
```

After this, you can look at the application at

http://localhost:8000/v1/resources/htmlServer?rs:home={path-to-tutorial}

{path-to-tutorial} is the path to this directory on your computer.  Use forward
slashes for the path, even on Windows.  example:
"/home/cgreer/semantics-tutorial" or "C:/semantics-tutorial"

Note: If you are on Windows, keep the path short, as the command for MLCP will
be too long if you have deeply nested directory.

#Contents

The HTML page at tutorial.html, invokes SPARQL queries or an extension
depending on which form is used.  The setup will have been installed by the
setup script.  Since MarkLogic serves this page directly from the filesystem,
you can edit it, save it and refresh your browser to see changes in the app.

Dring setup, the MLCP utility loads data from data/  There is JSON, and XML
data in this directory.  Some of the XML files are dumps of the internal
triples format of MarkLogic managed triples.

The `queries` directory contains qconsole workspaces, which can be imported from [QConsole|http://localhost:8000/qconsole].

