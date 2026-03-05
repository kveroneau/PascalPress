# PascalPress

The goal of this software will be to create a usable front-end suitable for use in custom HTML/CSS templates which acts as the glue and logic between the content and a compatible REST API backend server.  If you are capable enough to write your own REST API server implementation in Go for example, then this will be 100% possible.  I am trying to make the back-end as open as possible so that it can scale in which ever server-side language makes the most sense to any specific person or entity.

There will be a sample server provided in this project which will be built in ObjectPascal as well, but it is not required to use the front-end publishing client which the users will see.

One key feature of this software will be in security, whereas, a fully read-only REST API Server with a read-only connection to a compatible database server will be the only requirement.  All administrative tasks will instead take place in a dedicated desktop app which will initially communicate directly to the database, over an SSH connection for the most secure publishing experience possible.

## Main Features

  * Next generation take on my personal QVFS technology, aptly called BlogFS here
    - Will allow the publishing platform to be easily extended with multiple new content types with little effort
  * Desktop administrative application will feature a familiar "Explorer" style interface
    - Navigate your website's content and virtual files with ease
    - Documentation will be provided on how to add new content types for both web client and Desktop app
  * Custom 3rd party plugins and add-ons will be possible and 100% sandboxed
    - 3rd party plugins and add-ons will not have full JavaScript support
    - Instead, each plugin/add-on will be sandboxed in a 6502 virtual environment with API access
    - This ensures that no 3rd party plugin does something it shouldn't and can be better monitored
    - The 6502 plugin/addon system will support Assembly, C, and of course Pascal programs
